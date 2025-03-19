import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/explore/widgets/explore_movie_card.dart';

class AnimatedMoviePicWidget extends StatefulWidget {
  final MovieEntity movie;
  final int index;

  const AnimatedMoviePicWidget({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  _AnimatedMoviePicWidgetState createState() => _AnimatedMoviePicWidgetState();
}

class _AnimatedMoviePicWidgetState extends State<AnimatedMoviePicWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: MoviePicWidget(movie: widget.movie),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}




