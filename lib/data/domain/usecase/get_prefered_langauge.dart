import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/app_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetPreferedLangauge extends Usecase<String, NoParams> {
  final AppRepository appRepository;
  GetPreferedLangauge({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, String>> call(NoParams noParams) async {
    return await appRepository.getPreferedLanguage();
  }
}
