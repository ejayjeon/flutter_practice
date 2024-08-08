part of '../provider.dart';

final historyApiProvider =
    Provider.family<HistoryApi, DioService>((_, dio) => HistoryApi(dio));

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final api = ref.watch(historyApiProvider(dio));
  final repository = HistoryReposiroryImpl(api);

  return repository;
});
