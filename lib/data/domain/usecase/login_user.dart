import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/login_request_params.dart';
import 'package:popcornhub/data/domain/repository/authentication_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class LoginUser extends Usecase<bool, LoginRequestParams> {
final AuthenticationRepository _authenticationRepository;
LoginUser(this._authenticationRepository);

@override
Future<Either<AppError, bool>> call(LoginRequestParams params)async =>
  _authenticationRepository.loginUser(params.toJson());
  


  
}