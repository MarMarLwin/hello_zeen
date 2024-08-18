import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/user_manager.dart';
import '../data/auth_repository.dart';

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier(this.authRepository) : super(const AsyncData(null));
  final AuthRepository authRepository;

  Future<bool> login(
      {required String username, required String password}) async {
    state = const AsyncValue.loading();
    LocalStorageManager.clearTokens();
    try {
      state = await AsyncValue.guard(
          () => authRepository.login(username: username, password: password));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
    return state.hasError == false;
  }

  Future<bool> logout() async {
    state = const AsyncValue.loading();
    try {
      Future.delayed(const Duration(milliseconds: 1000));

      state = await AsyncValue.guard(() => LocalStorageManager.clearTokens());
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    return state.hasError == false;
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthNotifier(authRepository);
});
