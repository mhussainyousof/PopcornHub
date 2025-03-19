import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/presentation/blocs/moviebygenre/movie_by_genre_bloc.dart';
import 'package:popcornhub/presentation/widget/button.dart';

class MoodMoviesScreen extends StatelessWidget {
  final String moodName;
  final int genreId;
  final String imageAsset; 

  const MoodMoviesScreen({
    Key? key,
    required this.moodName,
    required this.genreId,
    required this.imageAsset, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieByGenreBloc>(
      create: (context) => getItInstance<MovieByGenreBloc>()
        ..add(LoadMoviesByGenreEvent(MovieParams(genreId))),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$moodName Movies'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [          
              Hero(
                tag: 'mood_$moodName', 
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Lottie.asset(
                    height: 160,
                    width: 160,
                    imageAsset, 
                    repeat: true,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              BlocBuilder<MovieByGenreBloc, MovieByGenreState>(
                builder: (context, state) {
                  if (state is MovieByGenreLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: const Center(child: LinearProgressIndicator()),
                    );
                  }  
                  if (state is MovieByGenreError) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Button(
                            text: TranslationConstants.retry,
                            
                            onPressed: () {
                              context.read<MovieByGenreBloc>().add(
                                    LoadMoviesByGenreEvent(MovieParams(genreId)),
                                  );
                            },
                          ),
                        ],
                      ),
                    );
                  }    
                  if (state is MovieByGenreLoaded) {
                    final movies = state.movies;
                        
                    if (movies.isEmpty) {
                      return const Center(child: Text('No movies found!'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return _buildMovieItem(context, movie);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieItem(BuildContext context, MovieEntity movie) {
    final bool hasPoster = movie.posterPath.isNotEmpty;
    final String imageUrl = hasPoster
        ? '${ApiConstants.baseImageUrl}${movie.posterPath}'
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
      
        children: [
          Card(
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
}





