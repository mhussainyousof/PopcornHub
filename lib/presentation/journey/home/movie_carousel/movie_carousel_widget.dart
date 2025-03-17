import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_backdrop_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_data_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_page_view.dart';
import 'package:popcornhub/presentation/widget/movie_app_bar.dart';
import 'package:popcornhub/presentation/widget/separator.dart';

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
        Column(
          
          children: [
            MovieAppBar(),
            MoviePageView(
              movies: movies,
              initialPage : defaultIndex,
            ),
            MovieDataWidget(),
            Separator()
          ],
        ),
      ],
    );
  }
}