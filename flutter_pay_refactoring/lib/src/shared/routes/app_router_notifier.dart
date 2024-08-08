part of 'router.dart';

@riverpod
class AppRouterNotifier extends _$AppRouterNotifier implements Listenable {
  VoidCallback? routerListener;

  // LoginState loginState = const LoginInitial();

  @override
  Future<void> build() async {
    // LoginState loginState = ref.watch(loginControllerProvider);

    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}
