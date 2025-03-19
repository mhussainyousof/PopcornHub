import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_by_actor.dart';
import 'package:popcornhub/presentation/blocs/actor_movie/actor_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';

class ActorMoviesScreen extends StatelessWidget {
  final int actorId;
  const ActorMoviesScreen({required this.actorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Actor Movies'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ActorMovieBloc(
          getMovieByActor: getItInstance<GetMovieByActor>(),
        )..add(LoadedActorMovieEvent(actorId: actorId)),
        child: BlocBuilder<ActorMovieBloc, ActorMovieState>(
          builder: (context, state) {
            if (state is LoadedActorMovie) {
              final movies = state.movies;
              
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7, 
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteList.movieDetail,
                          arguments: MovieDetailArguments(movieId: movie.id),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  '${ApiConstants.baseImageUrl}${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title.intelliTrim(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        movie.releaseDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                       Text(
                                        '${movie.voteAverage.toStringAsFixed(1)} 🌟',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ErrorActorMovie) {
              return Text(state.message);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
