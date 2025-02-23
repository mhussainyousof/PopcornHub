import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/data_source/movie_remote_datasource.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/get_cast.dart';
import 'package:popcornhub/data/domain/usecase/get_comming_soon.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_detail.dart';
import 'package:popcornhub/data/domain/usecase/get_playingnow.dart';
import 'package:popcornhub/data/domain/usecase/get_popular.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';
import 'package:popcornhub/data/domain/usecase/get_videos.dart';
import 'package:popcornhub/data/domain/usecase/search_movie.dart';
import 'package:popcornhub/data/repository/movie_repo_impl.dart';
import 'package:popcornhub/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(
      () => ApiClient(getItInstance<Client>()));
  getItInstance.registerLazySingleton<MovieRemoteDatasource>(
      () => MovieRemoteDatasourceImpl(getItInstance<ApiClient>()));
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance<MovieRemoteDatasource>()));
  getItInstance.registerLazySingleton<GetTrending>(
      () => GetTrending(getItInstance<MovieRepository>()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton(() => GetCommingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance
      .registerFactory<CastBloc>(() => CastBloc(getCast: getItInstance()));
  getItInstance.registerFactory(() => MovieBackdropBloc());
  getItInstance.registerFactory<MovieCarouselBloc>(() => MovieCarouselBloc(
      movieBackdropBloc: getItInstance(), getTrending: getItInstance()));

  getItInstance.registerFactory(() => MovieTabbedBloc(
      getCommingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
      getPopular: getItInstance()));

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());

  getItInstance.registerFactory<MovieDetailBloc>(() => MovieDetailBloc(
      videoBloc: getItInstance(),
      castBloc: getItInstance(),
      getMovieDetail: getItInstance()));

  getItInstance
      .registerFactory<VideoBloc>(() => VideoBloc(getVideos: getItInstance()));
  getItInstance
      .registerFactory<SearchMovieBloc>(() => SearchMovieBloc(searchMovies: getItInstance()));
}
