import '../../../api_client/api_request.dart';
import '../../../api_client/http_method.dart';
import '../../../utils/api_const.dart';

class DataRequest {
  DataRequest._();

  static APIRequest getData() => APIRequest(
        method: HTTPMethods.get,
        path: ApiConst.getData,
      );
}
