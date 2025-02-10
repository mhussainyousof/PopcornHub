import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/data_source/movie_remote_datasource.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';
import 'package:popcornhub/data/repository/movie_repo_impl.dart';

void main() async {
  ApiClient apiClient = ApiClient(Client());
  MovieRemoteDatasource datasource = MovieRemoteDatasourceImpl(apiClient);
  MovieRepository movieRepository = MovieRepositoryImpl(datasource);
  GetTrending getTrending = GetTrending(movieRepository);
  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());
  eitherResponse.fold((failure) {
    print('Error: ${failure.message}');
  }, (movies) {
    print('${movies.length}');
    print (movies.take(3));
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
