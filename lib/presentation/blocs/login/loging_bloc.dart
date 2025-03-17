import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/login_request_params.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/login_user.dart';
import 'package:popcornhub/data/domain/usecase/logout_user.dart';
import 'package:popcornhub/presentation/blocs/laoding/loading_bloc.dart';
part 'loging_event.dart';
part 'loging_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final LoadingBloc loadingBloc;
  LoginBloc({
    required this.logoutUser,
    required this.loginUser,
    required this.loadingBloc
    }) : super(LogingInitial()) {
    on<LoginEvent>((event, emit) async {

      if (event is LoginIinitiateEvent) {
        loadingBloc.add(StartLoading());
        final Either<AppError, bool> eitherResonse = await loginUser(
            LoginRequestParams(
                userName: event.userName, password: event.password));
        eitherResonse.fold((l) {
          var message = getErrorMessage(l.appErrorType);
          return emit(LoginError(message));
        }, (r) {
          emit(LoginSuccess());
        });
        loadingBloc.add(FinishLoading());
      }else if(event is LogoutEvent){

        await logoutUser(NoParams());
        emit(LogoutSuccess());
      }
    });
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
