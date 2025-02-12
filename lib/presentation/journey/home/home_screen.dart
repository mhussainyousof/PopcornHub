import 'package:flutter/material.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late final MovieCarouselBloc movieCarouselBloc;

  @override
  void initState() {
    super.initState();
  movieCarouselBloc = getItInstance<MovieCarouselBloc>();
  movieCarouselBloc.add(MovieCarouselLoadedEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            child: Placeholder(
              color: Colors.green,
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.4,
            child: Placeholder(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
