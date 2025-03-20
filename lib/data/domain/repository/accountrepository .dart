import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';

abstract class AccountRepository {
  Future<Either<AppError, AccountEntity>> getAccountDetails();
}


