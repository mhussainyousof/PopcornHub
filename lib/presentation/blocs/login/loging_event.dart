// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'loging_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class LoginIinitiateEvent extends LoginEvent {
  final String userName, password;
  const LoginIinitiateEvent(
     this.password,
     this.userName
  );

  @override
  List<Object> get props => [userName, password];

}

@override
class LogoutEvent extends LoginEvent{

}
