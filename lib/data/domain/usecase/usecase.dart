import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';

abstract class Usecase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}