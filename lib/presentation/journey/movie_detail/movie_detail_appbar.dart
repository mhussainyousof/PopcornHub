import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';

class MovieDetailAppbar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;
  const MovieDetailAppbar({
    super.key,
    required this.movieDetailEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is IsFavoriteMovie) {
              return InkWell(
                onTap: () => BlocProvider.of<FavoriteBloc>(context).add(
                    ToggleFavoriteMovieEvent(
                        movieEntity: MovieEntity.fromMovieDetailEntity(movieDetailEntity), isFavorite: state.isMovieFavorite)),
                child: Icon(
                  state.isMovieFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 25,
                ),
              );
            } else {
              return Icon(Icons.favorite_border);
            }
          },
        )
      ],
    );
  }
}
