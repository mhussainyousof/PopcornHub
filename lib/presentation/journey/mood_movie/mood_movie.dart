import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/presentation/blocs/moviebygenre/movie_by_genre_bloc.dart';
import 'package:popcornhub/presentation/widget/button.dart';

class MoodMoviesScreen extends StatelessWidget {
  final String moodName;
  final int genreId;

  const MoodMoviesScreen({
    Key? key,
    required this.moodName,
    required this.genreId,
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
        body: BlocBuilder<MovieByGenreBloc, MovieByGenreState>(
          builder: (context, state) {
            if (state is MovieByGenreLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieByGenreError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 12),
                    Button(text: 'Retry', onPressed: (){
                      context.read<MovieByGenreBloc>().add(LoadMoviesByGenreEvent(MovieParams(genreId)));
                    })
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
                padding: const EdgeInsets.all(16),
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
      ),
    );
  }

Widget _buildMovieItem(BuildContext context, MovieEntity movie) {
  final bool hasPoster = movie.posterPath.isNotEmpty;
  final String imageUrl = hasPoster
      ? '${ApiConstants.baseImageUrl}${movie.posterPath}'
      : '';

  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 16),
    child: ListTile(
      leading: SizedBox(
        width: 50,
        height: 75,
        child: hasPoster
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.broken_image);
                },
              )
            : const Icon(Icons.image_not_supported), 
      ),
      title: Text(movie.title),
      subtitle: Text('Rating: ${movie.voteAverage}'),
      onTap: () {
      },
    ),
  );
}


}



