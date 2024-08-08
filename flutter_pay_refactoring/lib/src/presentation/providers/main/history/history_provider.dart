part of '../../provider.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  final repository = ref.watch(historyRepositoryProvider);

  return HistoryNotifier(repository);
});
