import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/model/accont_model.dart';

abstract class AccountRemoteDataSource {
  Future<AccountModel> getAccontDetails(String sessionId);

}

class AccountRemoteDataSourceImpl extends AccountRemoteDataSource {
    final ApiClient _client;

  AccountRemoteDataSourceImpl(this._client);
  @override
  Future<AccountModel> getAccontDetails(String sessionId)async {
    final response = await _client.get('account',
    params: {
      'api_key': ApiConstants.apiKey, 
        'session_id': sessionId,
    },
    );
    return AccountModel.fromJson(response);
  }
}
