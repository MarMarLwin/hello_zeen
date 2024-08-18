import 'package:hello_zeen/features/auth/presentation/login_page.dart';
import 'package:hello_zeen/features/home/presentation/home_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../utils/user_manager.dart';
import 'not_found_screen.dart';
part 'app_router.g.dart';

enum AppRoute { home, login }

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) async {
      final accessToken = await LocalStorageManager.getAccessToken();

      if (accessToken.isNotEmpty) {
        return '/home';
      } else {
        return '/';
      }
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
