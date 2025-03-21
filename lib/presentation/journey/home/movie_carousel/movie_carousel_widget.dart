import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_backdrop_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget{
  final List<MovieEntity> movies;
  final int defaultIndex;
  const MovieCarouselWidget({
    required this.movies,
    required this.defaultIndex,
    super.key}) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MovieBackdropWidget(),
        SingleChildScrollView(
          child: Column(
            children: [
             SizedBox(height: 20,),
              MoviePageView(
                movies: movies,
                initialPage : defaultIndex,
              ),
            ],
          ),
        ),
      ],
    );
  }
}