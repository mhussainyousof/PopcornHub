import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/app_localizations.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';
import 'package:popcornhub/presentation/wiredash_app.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final LanguageBloc _languageBloc;
  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _languageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: (context, child) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoaded) {
                return WiredashApp(
                  languageCode: state.locale.languageCode,
                  navigatorKey: _navigatorKey,
                  child: MaterialApp(
                    navigatorKey: _navigatorKey,
                    title: 'Movie App',
                    theme: ThemeData(
                      colorScheme: ColorScheme.light(
                        secondaryContainer: AppColor.royalBlue,
                        secondary: AppColor.royalBlue,
                        primary: AppColor.vulcan,
                        surface: AppColor.vulcan,
                      ),
                      textTheme: ThemeText.getTextTheme(),
                      appBarTheme: AppBarTheme(elevation: 0),
                    ),
                    supportedLocales:
                        Languages.languages.map((e) => Locale(e.code)).toList(),
                    locale: state.locale,
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      AppLocalizations.delegate
                    ],
                    home: HomeScreen(),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
