import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/data_source/account_remote_data_source.dart';
import 'package:popcornhub/data/data_source/authentication_local_data_source.dart';
import 'package:popcornhub/data/data_source/authintication_remote_data_source.dart';
import 'package:popcornhub/data/data_source/language_local_data_source.dart';
import 'package:popcornhub/data/data_source/movie_local_data_source.dart';
import 'package:popcornhub/data/data_source/movie_remote_datasource.dart';
import 'package:popcornhub/data/domain/repository/accountrepository%20.dart';
import 'package:popcornhub/data/domain/repository/app_repository.dart';
import 'package:popcornhub/data/domain/repository/authentication_repository.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/check_if_movie_favorite.dart';
import 'package:popcornhub/data/domain/usecase/delete_favorite_movie.dart';
import 'package:popcornhub/data/domain/usecase/get_account.dart';
import 'package:popcornhub/data/domain/usecase/get_actor.dart';
import 'package:popcornhub/data/domain/usecase/get_cast.dart';
import 'package:popcornhub/data/domain/usecase/get_comming_soon.dart';
import 'package:popcornhub/data/domain/usecase/get_favorite_movies.dart';
import 'package:popcornhub/data/domain/usecase/get_genre.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_by_actor.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_detail.dart';
import 'package:popcornhub/data/domain/usecase/get_playingnow.dart';
import 'package:popcornhub/data/domain/usecase/get_popular.dart';
import 'package:popcornhub/data/domain/usecase/get_prefered_langauge.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';
import 'package:popcornhub/data/domain/usecase/get_videos.dart';
import 'package:popcornhub/data/domain/usecase/login_user.dart';
import 'package:popcornhub/data/domain/usecase/logout_user.dart';
import 'package:popcornhub/data/domain/usecase/save_movie.dart';
import 'package:popcornhub/data/domain/usecase/search_movie.dart';
import 'package:popcornhub/data/domain/usecase/update_langauge.dart';
import 'package:popcornhub/data/repository/account_repositoryimpl%20.dart';
import 'package:popcornhub/data/repository/app_repo_impl.dart';
import 'package:popcornhub/data/repository/authentication_repository_impl.dart';
import 'package:popcornhub/data/repository/movie_repo_impl.dart';
import 'package:popcornhub/presentation/blocs/account/account_bloc.dart';
import 'package:popcornhub/presentation/blocs/actor/actor_bloc.dart';
import 'package:popcornhub/presentation/blocs/actor_movie/actor_movie_bloc.dart';
import 'package:popcornhub/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/blocs/laoding/loading_bloc.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:popcornhub/presentation/blocs/moviebygenre/movie_by_genre_bloc.dart';
import 'package:popcornhub/presentation/blocs/playing_now/playing_now_bloc.dart';
import 'package:popcornhub/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/blocs/soon/soon_bloc.dart';
import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  //! 🔹 Register API and HTTP Client
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance<Client>()));

  //! 🔹 Register Data Sources
  getItInstance.registerLazySingleton<MovieRemoteDatasource>(() => MovieRemoteDatasourceImpl(getItInstance<ApiClient>()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(()=> AuthenticationRemoteDataSourceImpl(getItInstance<ApiClient>()));
  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(()=> AuthenticationLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AccountRemoteDataSource>(()=> AccountRemoteDataSourceImpl(getItInstance<ApiClient>()));


  //! 🔹 Register Repository
  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(getItInstance<MovieLocalDataSource>(), getItInstance<MovieRemoteDatasource>()));
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepoImpl(languageLocalDataSource: getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(getItInstance<AuthenticationRemoteDataSource>(), getItInstance<AuthenticationLocalDataSource>()));
  getItInstance.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(getItInstance<AccountRemoteDataSource>(), getItInstance<AuthenticationLocalDataSource>()));


  //! 🔹 Register Use Cases
  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetCommingSoon>(() => GetCommingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance.registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(() => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfMovieFavoriteMovie>(() => CheckIfMovieFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLangauge>(() => UpdateLangauge(appRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetPreferedLangauge>(() => GetPreferedLangauge(appRepository: getItInstance()));
  getItInstance.registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));
  getItInstance.registerLazySingleton<GetMoviesByGenre>(() => GetMoviesByGenre(getItInstance()));
  getItInstance.registerLazySingleton<GetActors>(() => GetActors(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieByActor>(() => GetMovieByActor(movieRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetAccountDetails>(() => GetAccountDetails(getItInstance()));
  

  //! 🔹 Register BLoCs
  getItInstance.registerFactory<CastBloc>(() => CastBloc(getCast: getItInstance()));
  getItInstance.registerFactory<MovieBackdropBloc>(() => MovieBackdropBloc());
  getItInstance.registerFactory<MovieCarouselBloc>(() => MovieCarouselBloc(
    loadingBloc: getItInstance(),
    movieBackdropBloc: getItInstance(), getTrending: getItInstance()));
  getItInstance.registerFactory<MovieTabbedBloc>(() => MovieTabbedBloc(getCommingSoon: getItInstance(), getPlayingNow: getItInstance(), getPopular: getItInstance()));
  getItInstance.registerFactory<MovieDetailBloc>(() => MovieDetailBloc(
    loadingBloc: getItInstance(),
    favoriteBloc: getItInstance(), videoBloc: getItInstance(), castBloc: getItInstance(), getMovieDetail: getItInstance()));
  getItInstance.registerFactory<VideoBloc>(() => VideoBloc(getVideos: getItInstance()));
  getItInstance.registerFactory<SearchMovieBloc>(() => SearchMovieBloc(
    loadingBloc: getItInstance(),
    searchMovies: getItInstance()));
  getItInstance.registerFactory<FavoriteBloc>(() => FavoriteBloc(checkIfMovieFavoriteMovie: getItInstance(), deleteFavoriteMovie: getItInstance(), getFavoriteMovies: getItInstance(), saveMovie: getItInstance()));
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(getPreferedLangauge: getItInstance(), updateLangauge: getItInstance()));
  getItInstance.registerFactory<LoginBloc>(()=> LoginBloc(
    loadingBloc: getItInstance(),
    loginUser: getItInstance(), logoutUser: getItInstance()));
  getItInstance.registerSingleton<LoadingBloc>(LoadingBloc());
  getItInstance.registerSingleton<ThemeBloc>(ThemeBloc());
  getItInstance.registerFactory<MovieByGenreBloc>(
  () => MovieByGenreBloc(getMoviesByGenre: getItInstance()),
);
  getItInstance.registerFactory<ActorBloc>(
  () => ActorBloc(getActors: getItInstance()),
);
getItInstance.registerFactory<ActorMovieBloc>(
  () => ActorMovieBloc(
    getMovieByActor: getItInstance(),
  ),
);
getItInstance.registerFactory<PopularMoviesBloc>(
  () => PopularMoviesBloc(
    getPopular: getItInstance(),
  ),
);
getItInstance.registerFactory<PlayingNowBloc>(
  () => PlayingNowBloc(
    getPlayingNow: getItInstance(),
  ),
);
getItInstance.registerFactory<SoonBloc>(
  () => SoonBloc(
    getCommingSoon: getItInstance(),
  ),
);
getItInstance.registerFactory<AccountBloc>(
  () => AccountBloc(
    getAccountDetails: getItInstance(),
  ),
);
}
