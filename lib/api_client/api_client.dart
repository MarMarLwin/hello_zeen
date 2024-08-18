import 'package:dio/dio.dart';
import 'api_request.dart';

abstract class APIClient {
  Future<Response> execute({
    required APIRequest request,
  });
}
