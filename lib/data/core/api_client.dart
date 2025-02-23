import 'dart:convert';

import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_constants.dart';

class ApiClient {
  final Client _client;
  ApiClient(this._client);
    dynamic get(String path, {Map<dynamic, dynamic> params = const {}}) async{
      final response = await _client.get(Uri.parse(
        getPath(path, params)
      ),
      headers: {'Content-Type' : 'application/json'}
      
      );
      if(response.statusCode == 200){  
        return json.decode(response.body);
      }else{
        throw Exception(
          response.reasonPhrase
        );
      }
    }
 

  String getPath(String path, Map<dynamic, dynamic> params){
    var paramString = '';
    if(params.isNotEmpty){
      params.forEach((key, value){
        paramString += '&$key=$value';
      });
    }
    return '${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}$paramString';
  }

}