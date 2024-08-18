import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/api_const.dart';
import '../utils/user_manager.dart';
import 'api_client.dart';
import 'api_request.dart';
part 'rest_api_client.g.dart';

class RestAPIClient extends APIClient {
  static final RestAPIClient _instance = RestAPIClient._();

  RestAPIClient._();

  factory RestAPIClient() => _instance;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConst.baseUrl,
      // connectTimeout: const Duration(microseconds: 5000),
      // receiveTimeout: const Duration(microseconds: 3000),
    ),
  )..interceptors.addAll([
      LogInterceptor(),
    ]);

  @override
  Future<Response> execute({
    required APIRequest request,
  }) async {
    var accessToken = await LocalStorageManager.getAccessToken();
    if (accessToken.isNotEmpty) {
      request.headers = {'Authorization': accessToken};
    } else {
      request.headers = {'content-type': 'application/json'};
    }

    final options = Options(
      method: request.method.value,
      contentType: Headers.jsonContentType,
      headers: request.headers,
    );

    try {
      await checkInternetConnection();

      final response = await dio.request(
        request.path,
        queryParameters: request.parameters,
        data: request.body,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.first == ConnectivityResult.none) {
      throw 'Oh, you are not connected to internet!';
    }
  }
}

@Riverpod(keepAlive: true)
RestAPIClient restApiClient(RestApiClientRef ref) => RestAPIClient();
