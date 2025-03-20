import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/playing_now/playing_now_bloc.dart';
import 'package:popcornhub/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:popcornhub/presentation/blocs/soon/soon_bloc.dart';
import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:popcornhub/presentation/journey/explore/explore_cubit.dart';
import 'package:popcornhub/presentation/journey/explore/widgets/explore_listview.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/widget/app_dialog.dart';

class NavigationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>NavigationCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected:(index){
              context.read<NavigationCubit>().updateIndex(index);
            } ,
            destinations: [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Iconsax.video_play), label: 'Explore'),
              NavigationDestination(
                  icon: Icon(Iconsax.menu_board), label: 'Dashboard'),
            ],
          ),
        );
          },
        ),
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {

            return IndexedStack(
              index : currentIndex,
              children:[
                HomeScreen(),
                ExploreScreen(),
                DashboardScreen(),
              ]
            );

            // switch(currentIndex){
            //   case 0: 
            //   return HomeScreen();
            //   case 1:
            //   return ExploreScreen();
            //   case 2:
            //   return Placeholder();
            //   default:
            //   return HomeScreen();
            // } 
          },
        )
      ),
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
  void initState(){
    super.initState();
    popularMoviesBloc = getItInstance<PopularMoviesBloc>();
    popularMoviesBloc.add(PopMovieLoadedEvent());

    playingNowBloc = getItInstance<PlayingNowBloc>();
    playingNowBloc.add(NowLoadMovieEvent());

    soonBloc = getItInstance<SoonBloc>();
    soonBloc.add(SoonLoadMovieEvent());
  }

@override
void dispose(){
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
                          height: 190,
                            mainText: 'POPULAR', movies: movies),
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



class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();
    final languageBloc = context.read<LanguageBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileSection(),

          // 🌙 Toggle Theme
          Card(
            child: ListTile(
              leading: Icon(
                themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.deepPurple,
              ),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (_) {
                  themeBloc.add(ToggleThemeEvent());
                },
              ),
            ),
          ),

          // 🎬 Favorite Movies
          Card(
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.redAccent),
              title: Text('Favorite Movies'),
              onTap: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              },
            ),
          ),

          // 🌍 Change Language
          Card(
            child: ExpansionTile(
              leading: Icon(Icons.language, color: Colors.blueAccent),
              title: Text('Change Language'),
              children: Languages.languages.map((lang) {
                return ListTile(
                  title: Text(lang.value),
                  onTap: () {
                    languageBloc.add(ToggleLanguageEvent(lang));
                  },
                );
              }).toList(),
            ),
          ),

          // ℹ️ About
          Card(
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Colors.green),
              title: Text('About'),
              onTap: () => _showAboutDialog(context),
            ),
          ),

          // 🚪 Logout
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) => current is LogoutSuccess,
            listener: (context, state) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteList.initial,
                (route) => false,
              );
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.grey),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.loginScreen,
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/user_avatar.png'),
        ),
        title: Text('John Doe'),
        subtitle: Text('johndoe@example.com'),
        trailing: Icon(Icons.edit),
        onTap: () {
          // Navigate to edit profile page
        },
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


