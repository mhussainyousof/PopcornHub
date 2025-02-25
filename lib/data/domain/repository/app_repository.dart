import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';

abstract class AppRepository {
  Future<Either<AppError, void>> updateLanguage(String language);
  Future<Either<AppError, String>> getPreferedLanguage();

}