import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

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
                        movieEntity: MovieEntity.fromMovieDetailEntity(
                            movieDetailEntity),
                        isFavorite: state.isMovieFavorite)),
                child: Icon(
                  state.isMovieFavorite ? Iconsax.tick_square : Iconsax.save_2,
                  color:
                      state.isMovieFavorite ? AppColor.mintGreen : Colors.white,
                  size: 30,
                ),
              );
            } else {
              return Icon(Iconsax.save_2);
            }
          },
        )
      ],
    );
  }
}
