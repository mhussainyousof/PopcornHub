import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/presentation/blocs/account/account_bloc.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/playing_now/playing_now_bloc.dart';
import 'package:popcornhub/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:popcornhub/presentation/blocs/soon/soon_bloc.dart';
import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:popcornhub/presentation/journey/explore/explore_cubit.dart';
import 'package:popcornhub/presentation/journey/explore/explore_listview.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/widget/app_dialog.dart';
import 'package:switcher_button/switcher_button.dart';



class NavigationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(getAccountDetails: getItInstance())
            ..add(LoadAccountDetailsEvent()),
        )
      ],
      child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColor.richBlack.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, -2)),
              ],
            ),
            child: BlocBuilder<NavigationCubit, int>(
              builder: (context, currentIndex) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: NavigationBar(
                    animationDuration: Duration(seconds: 1),
                    backgroundColor: Colors.transparent,
                    indicatorColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      context.read<NavigationCubit>().updateIndex(index);
                    },
                    destinations: [
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.home, size: 27),
                          icon: Icon(Iconsax.home),
                          label: 'Home'),
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.video_play, size: 27),
                          icon: Icon(Iconsax.video_play),
                          label: 'Explore'),
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.menu_board, size: 27),
                          icon: Icon(Iconsax.menu_board),
                          label: 'Dashboard'),
                    ],
                  ),
                );
              },
            ),
          ),
          body: BlocBuilder<NavigationCubit, int>(
            builder: (context, currentIndex) {
              return IndexedStack(index: currentIndex, children: [
                HomeScreen(),
                ExploreScreen(),
                DashboardScreen(),
              ]);
            },
          )),
    );
  }
}

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final PopularMoviesBloc popularMoviesBloc;
  late final PlayingNowBloc playingNowBloc;
  late final SoonBloc soonBloc;

  @override
  void initState() {
    super.initState();
    popularMoviesBloc = getItInstance<PopularMoviesBloc>();
    popularMoviesBloc.add(PopMovieLoadedEvent());

    playingNowBloc = getItInstance<PlayingNowBloc>();
    playingNowBloc.add(NowLoadMovieEvent());

    soonBloc = getItInstance<SoonBloc>();
    soonBloc.add(SoonLoadMovieEvent());
  }

  @override
  void dispose() {
    popularMoviesBloc.close();
    playingNowBloc.close();
    soonBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: popularMoviesBloc),
        BlocProvider.value(value: playingNowBloc),
        BlocProvider.value(value: soonBloc),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                    if (state is PopMovieLoadedState) {
                      final movies = state.movies;
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ExploreListview(
                            height: 190, mainText: 'POPULAR', movies: movies),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                BlocBuilder<PlayingNowBloc, PlayingNowState>(
                  builder: (context, state) {
                    if (state is NowLoadedMovieState) {
                      final movies = state.movies;
                      return ExploreListview(
                          textDirection2: TextDirection.rtl,
                          left_height: 2,
                          height: 180,
                          textDirection: TextDirection.rtl,
                          movies: movies,
                          mainText: 'Now');
                    }
                    return SizedBox.shrink();
                  },
                ),
                BlocBuilder<SoonBloc, SoonState>(
                  builder: (context, state) {
                    if (state is SoonLoadedMovieState) {
                      final movies = state.movies;
                      return ExploreListview(
                          height: 180, movies: movies, mainText: 'SOON');
                    }
                    return SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isCheckedTheme = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();
    final languageBloc = context.read<LanguageBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoaded) {
                return _buildProfileSection(state.account);
              } else if (state is AccountLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AccountError) {
                return const Center(
                    child: Text('Error loading account details'));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
          const SizedBox(height: 16),
          _buildFavoriteSection(context),
          const SizedBox(height: 16),
          _buildLanguageSwitcher(languageBloc),
          const SizedBox(height: 16),
          _buildAboutSection(context),
          const SizedBox(height: 16),
          _buildThemeSwitcher(themeMode, themeBloc),
          const SizedBox(height: 16),
          _buildLogoutSection(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(AccountEntity account) {
    return Card(
      child: ListTile(
        minTileHeight: 70,
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}${account.avatarPath}',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Iconsax.profile_circle),
          ),
        ),
        title: Text(account.username),
      ),
    );
  }

  Widget _buildThemeSwitcher(ThemeMode themeMode, ThemeBloc themeBloc) {
    return Card(
      child: ListTile(
        leading: Icon(
          themeMode == ThemeMode.dark ? Iconsax.moon : Iconsax.sun_1,
          color: AppColor.electricBlue,
        ),
        title: Text('App Theme'),
        trailing: SwitcherButton(
          onColor: AppColor.mintGreen,
          offColor: Colors.grey.shade300,
          value: themeMode == ThemeMode.dark,
          size: 45,
          onChange: (value) {
            setState(() {
              _isCheckedTheme = value;
            });
            themeBloc.add(ToggleThemeEvent());
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Iconsax.gallery_export, color: Colors.redAccent),
        title: const Text('Watch Later'),
        onTap: () => Navigator.of(context).pushNamed(RouteList.favorite),
      ),
    );
  }

  Widget _buildLanguageSwitcher(LanguageBloc languageBloc) {
    return Card(
      child: ExpansionTile(
        leading: const Icon(Iconsax.global, color: AppColor.deepPurple),
        title: const Text('Change Language'),
        children: Languages.languages.map((lang) {
          return ListTile(
            title: Text(lang.value),
            onTap: () => languageBloc.add(ToggleLanguageEvent(lang)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Iconsax.info_circle, color: Colors.green),
        title: const Text('About'),
        onTap: () => _showAboutDialog(context),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LogoutSuccess,
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteList.initial,
          (route) => false,
        );
      },
      child: Card(
        child: ListTile(
          leading: const Icon(Iconsax.logout, color: Colors.grey),
          title: const Text('Logout'),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteList.loginScreen,
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          buttonText: TranslationConstants.okay,
          image: Image.asset('assets/pngs/tmdb_logo.png', scale: 1.5),
          title: TranslationConstants.about,
          description: TranslationConstants.aboutDescription,
        );
      },
    );
  }
}
