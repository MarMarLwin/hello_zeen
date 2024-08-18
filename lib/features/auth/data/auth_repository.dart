import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../api_client/rest_api_client.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/user_manager.dart';
import '../domain/auth_model.dart';
import 'auth_request.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.client});
  final RestAPIClient client;
  AuthModel? authModel;

  Future<void> login(
      {required String username, required String password}) async {
    LocalStorageManager.clearTokens();
    var response = await client.execute(
        request: AuthRequest.login(username: username, password: password));
    // var apiResponse = APIResponse.fromJson(response.data);

    authModel = AuthModel.fromJson(response.data);
    await LocalStorageManager.savePreferenceData(
        AppConstant.accessToken, authModel?.token ?? '');
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(client: ref.watch(restApiClientProvider));
