import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountDetails getAccountDetails;
  AccountBloc({
    required this.getAccountDetails,
  }) : super(AccountInitial()) {
    on<LoadAccountDetailsEvent>((event, emit)async {
       emit(AccountLoading());
      final response = await getAccountDetails(NoParams());

        response.fold((error){emit(AccountError('Wrong data'));

        }, (right){
          emit(AccountLoaded(right));
        });
      
    });
  }
}
