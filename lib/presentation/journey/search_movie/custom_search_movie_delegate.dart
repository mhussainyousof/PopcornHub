import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/search_movie/search_movie_card.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';
import 'package:popcornhub/presentation/widget/app_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.greySubtitle1));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 19,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(SearchTermChangesEvent(query));

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: searchMovieBloc,
      builder: (context, state) {
        if (state is SearchMovieError) {
          return AppErrorWidget(
              errorType: state.appError,
              onPressed: () {
                searchMovieBloc.add(SearchTermChangesEvent(query));
              });
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Text(
                  textAlign: TextAlign.center,
                  TranslationConstants.noMoviesSearched.t(context)),
            );
          }

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return SearchMovieCard(
                  movie: movies[index],
                );
              });
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}
