part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}


class LoadAccountDetailsEvent extends AccountEvent {

  @override
  List<Object> get props => [];
}

