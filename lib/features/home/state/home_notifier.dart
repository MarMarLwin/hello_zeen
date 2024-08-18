// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hello_zeen/features/home/data/home_repository.dart';

class HomeNotifier extends StateNotifier<AsyncValue<void>> {
  HomeNotifier(
    this.homeRepository,
  ) : super(const AsyncData(null));

  final HomeRepository homeRepository;

  String? homeData;

  Future<String?> getData() async {
    final data = await homeRepository.getData();
    homeData = data;
    return homeData;
  }
}

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, AsyncValue<void>>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeNotifier(homeRepository);
});
