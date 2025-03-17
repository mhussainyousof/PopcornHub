import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/search_movie/search_movie_card.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';
import 'package:popcornhub/presentation/widget/app_error_widget.dart';

//! 🔍 CustomSearchDelegate: Handles movie search functionality 🔍
//! Uses SearchDelegate to provide search UI and handles search queries.

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  //! Constructor to initialize SearchMovieBloc
  CustomSearchDelegate(this.searchMovieBloc);

  //! 🎨 Defines the theme for the search bar
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1, //! Applies custom hint text style
      ),
    );
  }

  //! ✖️ Defines the actions on the right side of the search bar (Clear Button)
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: query.isEmpty ? Colors.grey : AppColor.charcoalGrey, //! Changes color based on query
        ),
        onPressed: () {
          query.isEmpty ? null : query = ''; //! Clears search query when clicked
        },
      ),
    ];
  }

  //! 🔙 Defines the leading widget (Back Button)
  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
      onTap: () {
        close(context, null); //! Closes search UI and returns to the previous screen
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.grey,
        size: 19,
      ),
    );
  }

  //! 🔎 Handles search results and updates UI dynamically
  @override
  Widget buildResults(BuildContext context) {
    //! Dispatch search event when query changes
    searchMovieBloc.add(SearchTermChangesEvent(query));

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: searchMovieBloc,
      builder: (context, state) {
        //! 🚨 Show error widget if search fails
        if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.appError,
            onPressed: () {
              searchMovieBloc.add(SearchTermChangesEvent(query)); //! Retry search
            },
          );
        } 
        //! 🎥 Display search results if movies are found
        else if (state is SearchMovieLoaded) {
          final movies = state.movies;

          //! 🚫 Show "No Movies Found" message if search returns empty
          if (movies.isEmpty) {
            return Center(
              child: Text(
                textAlign: TextAlign.center,
                TranslationConstants.noMoviesSearched.t(context),
              ),
            );
          }

          //! ✅ Show movie list when search is successful
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return SearchMovieCard(
                movie: movies[index], //! Displays each movie in the search results
              );
            },
          );
        }

        //! 🔄 Default fallback: Returns an empty widget while loading
        return SizedBox.shrink();
      },
    );
  }

  //! 💡 Displays search suggestions while typing (Not implemented)
  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink(); //! No suggestions provided
  }
}
