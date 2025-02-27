part of 'loging_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LogingInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LogoutSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}
