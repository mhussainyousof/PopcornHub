import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';

//! 🎬 Favorite Movie Card Widget 🎬
//! Displays a movie card with an image & a delete button for favorites.
class FavoriteMovieCardWidget extends StatelessWidget {
  final MovieEntity movie;

  const FavoriteMovieCardWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //! Adds padding & margin for proper spacing
      padding: EdgeInsets.symmetric(horizontal: 3),
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r), //! Smooth rounded corners
      ),
      child: Stack(
        children: [
          //! 🔥 Clickable movie poster (Navigates to movie details)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteList.movieDetail,
                arguments: MovieDetailArguments(movieId: movie.id),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9.r), //! Rounded corners
              child: CachedNetworkImage(
                //! Fetch movie poster from API
                imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                fit: BoxFit.cover, //! Makes sure image fits well
              ),
            ),
          ),

          //! 🗑️ Delete button (Removes movie from favorites)
          Align(
            alignment: Alignment.topRight, //! Positioning delete icon
            child: GestureDetector(
              onTap: () => BlocProvider.of<FavoriteBloc>(context)
                  .add(DeleteFavoriteMovieEvent(movie.id)), //! Dispatch delete event
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.delete, color: Colors.redAccent), //! Delete icon
              ),
            ),
          ),
        ],
      ),
    );
  }
}

