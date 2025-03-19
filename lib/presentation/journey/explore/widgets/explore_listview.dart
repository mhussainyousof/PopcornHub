import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/explore/widgets/explore_animated_movie_card.dart';
import 'package:popcornhub/presentation/journey/explore/widgets/explore_animated_text.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class ExploreListview extends StatelessWidget {
  const ExploreListview({
    super.key,
    required this.movies,
    this.height = 180,
    this.Container_color = AppColor.deepPurple,
    required this.mainText,
    this.listview_height = 200,
    this.textDirection = TextDirection.ltr,
    this.left_height = 0,
  });

  final List<MovieEntity> movies;
  final double height;
  final Color? Container_color;
  final String mainText;
  final double listview_height;
  final double left_height;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13.0),
      child: Row(
        textDirection: textDirection,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: height,
            width: 20,
            margin: EdgeInsets.only(right: 2, left: left_height),
            padding: const EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.deepPurple, AppColor.electricBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: AnimatedText(text: mainText), 
          ),
          Expanded(
            child: SizedBox(
              height: listview_height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return AnimatedMoviePicWidget(
                    movie: movie,
                    index: index,
                  ); 
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
