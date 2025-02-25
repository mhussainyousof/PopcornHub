import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/repository/app_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class UpdateLangauge extends Usecase<void, String> {
  final AppRepository appRepository;
  UpdateLangauge({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, void>> call(String languageCode) async {
    return await appRepository.updateLanguage(languageCode);
  }
}
