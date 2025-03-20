part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();
  
  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}
final class AccountLoading extends AccountState {}
class AccountLoaded extends AccountState {
  final AccountEntity account;

  AccountLoaded(this.account);

  @override
  List<Object> get props => [account];
}


class AccountError extends AccountState {
  final String message;

  AccountError(this.message);


   @override
  List<Object> get props => [message];
}