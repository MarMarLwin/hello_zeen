import 'dart:convert';
import 'package:hello_zeen/utils/api_const.dart';
import 'package:hello_zeen/utils/user_manager.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_manager.g.dart';

/// TODO DELETE
/// just testing for token invalid format

class HttpManager {
  Future<Map<String, dynamic>> get(String requestUrl) async {
    try {
      final token = await LocalStorageManager.getAccessToken();
      var url = Uri.parse(ApiConst.baseUrl + requestUrl);
      var header = {'Authorization': token};
      var response = await http.get(url, headers: header);
      Map<String, dynamic> jsonBody = json.decode(response.body);
      return jsonBody;
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<Map<String, dynamic>> post(
      String requestUrl, Map<String, dynamic> params) async {
    try {
      final token = await LocalStorageManager.getAccessToken();
      var url = Uri.parse(ApiConst.baseUrl + requestUrl);
      var header = {'Authorization': token, 'Content-Type': 'application/json'};
      var param = jsonEncode(params);
      var response = await http.post(url, headers: header, body: param);
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } catch (e) {
      throw Exception(e);
    }
  }
}

@Riverpod(keepAlive: true)
HttpManager httpManager(HttpManagerRef ref) => HttpManager();
