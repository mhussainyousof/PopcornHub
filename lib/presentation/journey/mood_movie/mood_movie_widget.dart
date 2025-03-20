  import 'package:flutter/material.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';

Widget buildMovieItem(BuildContext context, MovieEntity movie) {
    final bool hasPoster = movie.posterPath.isNotEmpty;
    final String imageUrl = hasPoster
        ? '${ApiConstants.baseImageUrl}${movie.posterPath}'
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
      
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(RouteList.movieDetail, arguments: MovieDetailArguments(movieId: movie.id));
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: 
                 hasPoster
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        width: 100,
                        height: 100,
                          imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.broken_image);
                          },
                        ),
                    )
                    : const Icon(Icons.image_not_supported),
              ),
          ),
            SizedBox(width: 12,),
               Expanded(
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(movie.title,
                               style: Theme.of(context).textTheme.bodyMedium,
                     overflow: TextOverflow.ellipsis,
                     ),
                     SizedBox(height: 20,),
                 Text('⭐ ${movie.voteAverage.toStringAsFixed(1)}',
                 style: Theme.of(context).textTheme.labelMedium,
                 ),
                   ],
                 ),
               ),
        ],
      ),
    );
    
  }