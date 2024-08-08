part of 'router.dart';

@riverpod
AppRouterInterceptor appRouterInterceptor(AppRouterInterceptorRef ref) {
  return AppRouterInterceptorImpl(ref);
}

abstract class AppRouterInterceptor {
  FutureOr<String?> canGo(BuildContext context, GoRouterState state);
}

class AppRouterInterceptorImpl implements AppRouterInterceptor {
  final Ref ref;
  AppRouterInterceptorImpl(this.ref);
  @override
  FutureOr<String?> canGo(BuildContext context, GoRouterState state) {
    final uri = state.uri;
    final needPinCheck = uri.path == AppRoute.account;
    final qrPaymentPage = uri.path == QRPaymentRoute.path;

    // 핀체크가 필요한 페이지
    if (needPinCheck) {
      return PinCheckRoute.path;
    }

    // QR Payment Tab 을 누르면 QR 카메라가 켜지게 리다이렉트
    if (qrPaymentPage) {
      return QrRoute.path;
    }

    return null;
  }
}
