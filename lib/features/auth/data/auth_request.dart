import '../../../api_client/api_request.dart';
import '../../../api_client/http_method.dart';
import '../../../utils/api_const.dart';

class AuthRequest {
  AuthRequest._();

  static APIRequest login(
          {required String username, required String password}) =>
      APIRequest(
          method: HTTPMethods.post,
          path: ApiConst.login,
          body: {'username': username, 'password': password});
}
