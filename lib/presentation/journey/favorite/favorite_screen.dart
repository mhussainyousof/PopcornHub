import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/journey/favorite/favorite_movie_grid_view.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getItInstance<FavoriteBloc>();
    _favoriteBloc.add(LoadFavoriteMovieEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationConstants.favoriteMovies.t(context),
        ),
        centerTitle: true,
      ),
      body: BlocProvider.value(
          value: _favoriteBloc,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
            if (state is FavoriteMovieLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                    child: Text(
                  TranslationConstants.noFavoriteMovie.t(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ));
              }
              return FavoriteMovieGridView(state.movies);
            }
            return SizedBox.shrink();
          })),
    );
  }
}
