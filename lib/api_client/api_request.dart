import 'http_method.dart';

class APIRequest {
  APIRequest({
    required this.method,
    required this.path,
    this.headers,
    this.parameters,
    this.body,
  });

  HTTPMethod method;
  String path;
  dynamic headers;
  dynamic parameters;
  dynamic body;
}
