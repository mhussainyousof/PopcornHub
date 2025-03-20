import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/data_source/account_remote_data_source.dart';
import 'package:popcornhub/data/data_source/authentication_local_data_source.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/repository/accountrepository%20.dart';

class AccountRepositoryImpl extends AccountRepository{
  final AccountRemoteDataSource _remoteDataSource;
  final AuthenticationLocalDataSource _localDataSource;

    AccountRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<AppError, AccountEntity>> getAccountDetails()async {
    try{
      final sessionId =  await _localDataSource.getSessionId();
      if (sessionId == null) {
      return left(AppError(AppErrorType.sessionDenied));
    }
      final AccountModel = await _remoteDataSource.getAccontDetails(sessionId);
      return right(AccountModel.toEntity());
    }on SocketException {
    return left(AppError(AppErrorType.network));
  } on Exception {
    return left(AppError(AppErrorType.api));
  }
  }

}