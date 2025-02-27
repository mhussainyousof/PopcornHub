import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/authentication_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class LogoutUser extends Usecase<void, NoParams>{
  final AuthenticationRepository _authenticationRepository;
  LogoutUser(this._authenticationRepository);
  @override
  Future<Either<AppError, void>> call(NoParams params) =>
    
   _authenticationRepository.logoutUser(); 
  

}