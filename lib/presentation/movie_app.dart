import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/app_localizations.dart';
import 'package:popcornhub/presentation/blocs/laoding/loading_bloc.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:popcornhub/presentation/fade_page_route_builder.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/journey/loading/loading_screen.dart';
import 'package:popcornhub/presentation/routes.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final LanguageBloc _languageBloc;
  late final LoginBloc _loginBloc;
  late final LoadingBloc _loadingBloc;
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferedLanguageEvent());
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
    _themeBloc = getItInstance<ThemeBloc>(); // ✅ Use GetIt instance
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
    super.dispose(); // ❌ Do NOT close `_themeBloc`, as it's a singleton
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<LoginBloc>.value(value: _loginBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
        BlocProvider<ThemeBloc>.value(value: _themeBloc),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeMode>( // ✅ Listen to ThemeBloc
            builder: (context, themeMode) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  if (state is LanguageLoaded) {
                    return WiredashApp(
                      languageCode: state.locale.languageCode,
                      navigatorKey: _navigatorKey,
                      child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        navigatorKey: _navigatorKey,
                        title: 'Movie App',
                        theme: AppTheme.lightTheme(),
                        darkTheme: AppTheme.darkTheme(),
                        themeMode: themeMode, 
                        supportedLocales: Languages.languages
                            .map((e) => Locale(e.code))
                            .toList(),
                        locale: state.locale,
                        localizationsDelegates: [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          AppLocalizations.delegate
                        ],
                        builder: (context, child) {
                          return LoadingScreen(screen: child!);
                        },
                        initialRoute: RouteList.initial,
                        onGenerateRoute: (RouteSettings settings) {
                          final routes = Routes.getRoutes(settings);
                          final WidgetBuilder? builder = routes[settings.name];
                          if (builder != null) {
                            return FadePageRouteBuilder(
                              builder: builder,
                              settings: settings,
                            );
                          }
                          return MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          );
        },
      ),
    );
  }
}
