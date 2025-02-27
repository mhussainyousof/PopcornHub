import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/core/unathorised_exception.dart';
import 'package:popcornhub/data/data_source/authentication_local_data_source.dart';
import 'package:popcornhub/data/data_source/authintication_remote_data_source.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/repository/authentication_repository.dart';
import 'package:popcornhub/data/model/request_token_model.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource,
      this._authenticationLocalDataSource);

  Future<Either<AppError, RequestTokenModel?>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return right(response);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 =
        requestTokenEitherResponse.getOrElse(() => null)?.requestToken ?? '';
    try {
      body.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.toJson());
      if (sessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        return right(true);
      }
      return left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on UnathorisedException {
      return left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    await Future.wait([
      _authenticationLocalDataSource.deleteSessionId(),
      _authenticationRemoteDataSource.deleteSession(sessionId!)
    ]);
    print(await _authenticationLocalDataSource.getSessionId());
    return right(unit);
  }
}
