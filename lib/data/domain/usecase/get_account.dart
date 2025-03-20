import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/accountrepository%20.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetAccountDetails extends Usecase<AccountEntity, NoParams> {
  final AccountRepository _repository;

  GetAccountDetails(this._repository);

  @override
Future<Either<AppError, AccountEntity>> call(NoParams params) async {
  final result = await _repository.getAccountDetails();
  return result;
}

}
