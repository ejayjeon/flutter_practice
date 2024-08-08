part of 'router.dart';

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  final interceptor = ref.watch(appRouterInterceptorProvider);
  final notifier = ref.watch(appRouterNotifierProvider.notifier);
  return AppRouter(notifier, interceptor);
}

class AppRouter {
  final Listenable notifier;
  final AppRouterInterceptor interceptor;
  AppRouter(this.notifier, this.interceptor);

  late final config = GoRouter(
    initialLocation: ResetPinRoute.path,
    navigatorKey: NavigatorKey._routerKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    refreshListenable: notifier,
    observers: [
      AppRouterObserver(),
    ],
    redirect: (context, state) async {
      final String? result = await interceptor.canGo(context, state);
      if (result != null) return result;
      return null;
    },
  );
}
