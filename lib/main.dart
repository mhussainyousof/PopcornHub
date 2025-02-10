import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';

void main() async {
  await init();
  GetTrending getTrending = getItInstance<GetTrending>();
  final Either<AppError, List<MovieEntity>> eitherResponse =
      await getTrending(NoParams());
  eitherResponse.fold(
    (failure) => print('Error: ${failure.message}'),
    (movies) => print('${movies.length}'),
  );
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
