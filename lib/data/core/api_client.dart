import 'dart:convert';
import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/core/unathorised_exception.dart';

class ApiClient {
  final Client _client;
  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic> params = const {}}) async {
    final response = await _client.get(Uri.parse(getPath(path, params)),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  

  dynamic post(String path, Map<dynamic, dynamic> params) async {
    final response = await _client.post(Uri.parse(getPath(path, {})),
        body: jsonEncode(params),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnathorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }


  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>params = const{}})async{
    Request request = Request('DELETE', Uri.parse(getPath(path, params)));
    request.headers['Content-Type'] = 'application/json';
    request.body =  jsonEncode(params);
    final response = await _client.send(request);
    final responseBody = await Response.fromStream(response);


    if (response.statusCode == 200){
      return jsonDecode(responseBody.body);
    }else if(response.statusCode == 401){
      throw UnathorisedException();
    }else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<dynamic, dynamic> params) {
    var paramString = '';
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        paramString += '&$key=$value';
      });
    }
    return '${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}$paramString';
  }
}
