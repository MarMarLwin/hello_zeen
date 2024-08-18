import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../api_client/rest_api_client.dart';
part 'home_repository.g.dart';

class HomeRepository {
  HomeRepository({required this.client});
  final RestAPIClient client;

  Future<String> getData() async {
    /// ****** just comment token invalid formt exceptions  because of without encryption token

    // var response = await client.execute(request: DataRequest.getData());

    // return response.toString();
    return 'hello ...';
  }
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) =>
    HomeRepository(client: ref.watch(restApiClientProvider));
