import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>>  loginUser(Map<String, dynamic> params);
  Future<Either<AppError, void>> logoutUser();
}