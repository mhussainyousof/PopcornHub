import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/data_source/language_local_data_source.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/repository/app_repository.dart';

class AppRepoImpl extends AppRepository {

  final LanguageLocalDataSource languageLocalDataSource;
  AppRepoImpl({
    required this.languageLocalDataSource,
  });
  
  @override
  Future<Either<AppError, String>> getPreferedLanguage()async {
   try{
    final response = await  languageLocalDataSource.getPreferedLanguage();
    return right(response);
   }on Exception{
    return left(AppError(AppErrorType.database));
   }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language)async {
    try{
    final response = await  languageLocalDataSource.updateLanguage(language);
    return right(response);
   }on Exception{
    return left(AppError(AppErrorType.database));
   }
  }
}
