// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $loginRoute,
      $findInfoRoute,
      $resetPinRoute,
      $pinCheckRoute,
      $mainShellRoute,
      $qrRoute,
      $historyDetailRoute,
      $paymentRoute,
      $subShellRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $AfterLoginRouteExtension._fromState,
        ),
      ],
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AfterLoginRouteExtension on AfterLoginRoute {
  static AfterLoginRoute _fromState(GoRouterState state) => AfterLoginRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/login/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $findInfoRoute => GoRouteData.$route(
      path: '/find-info',
      factory: $FindInfoRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $FindInfoDetailRouteExtension._fromState,
        ),
      ],
    );

extension $FindInfoRouteExtension on FindInfoRoute {
  static FindInfoRoute _fromState(GoRouterState state) => FindInfoRoute();

  String get location => GoRouteData.$location(
        '/find-info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FindInfoDetailRouteExtension on FindInfoDetailRoute {
  static FindInfoDetailRoute _fromState(GoRouterState state) =>
      FindInfoDetailRoute(
        state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/find-info/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $resetPinRoute => GoRouteData.$route(
      path: '/reset-pin',
      factory: $ResetPinRouteExtension._fromState,
    );

extension $ResetPinRouteExtension on ResetPinRoute {
  static ResetPinRoute _fromState(GoRouterState state) => ResetPinRoute();

  String get location => GoRouteData.$location(
        '/reset-pin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pinCheckRoute => GoRouteData.$route(
      path: '/pin-check',
      factory: $PinCheckRouteExtension._fromState,
    );

extension $PinCheckRouteExtension on PinCheckRoute {
  static PinCheckRoute _fromState(GoRouterState state) => PinCheckRoute();

  String get location => GoRouteData.$location(
        '/pin-check',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
      factory: $MainShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/qr-payment',
              factory: $QRPaymentRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/history',
              factory: $HistoryRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QRPaymentRouteExtension on QRPaymentRoute {
  static QRPaymentRoute _fromState(GoRouterState state) => QRPaymentRoute();

  String get location => GoRouteData.$location(
        '/qr-payment',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HistoryRouteExtension on HistoryRoute {
  static HistoryRoute _fromState(GoRouterState state) => HistoryRoute();

  String get location => GoRouteData.$location(
        '/history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qrRoute => GoRouteData.$route(
      path: '/qr',
      factory: $QrRouteExtension._fromState,
    );

extension $QrRouteExtension on QrRoute {
  static QrRoute _fromState(GoRouterState state) => QrRoute();

  String get location => GoRouteData.$location(
        '/qr',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $historyDetailRoute => GoRouteData.$route(
      path: '/history/details',
      factory: $HistoryDetailRouteExtension._fromState,
    );

extension $HistoryDetailRouteExtension on HistoryDetailRoute {
  static HistoryDetailRoute _fromState(GoRouterState state) =>
      HistoryDetailRoute();

  String get location => GoRouteData.$location(
        '/history/details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paymentRoute => GoRouteData.$route(
      path: '/payment',
      factory: $PaymentRouteExtension._fromState,
    );

extension $PaymentRouteExtension on PaymentRoute {
  static PaymentRoute _fromState(GoRouterState state) => PaymentRoute();

  String get location => GoRouteData.$location(
        '/payment',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $subShellRoute => StatefulShellRouteData.$route(
      factory: $SubShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/account-info',
              factory: $AccountRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: '/pin-check',
              factory: $PinCheckRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/withdraw',
              factory: $WithdrawRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'rewards',
                  factory: $WithdrawRewardsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'holdings',
                  factory: $WithdrawHoldingsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/family-app',
              factory: $FamilyAppRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/setting',
              factory: $SettingRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'language',
                  factory: $LanguageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'currency',
                  factory: $CurrencyRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'alert',
                  factory: $AlertRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'address-book',
                  factory: $AddressBookRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/notice',
              factory: $NoticeRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $SubShellRouteExtension on SubShellRoute {
  static SubShellRoute _fromState(GoRouterState state) => const SubShellRoute();
}

extension $AccountRouteExtension on AccountRoute {
  static AccountRoute _fromState(GoRouterState state) => AccountRoute();

  String get location => GoRouteData.$location(
        '/account-info',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WithdrawRouteExtension on WithdrawRoute {
  static WithdrawRoute _fromState(GoRouterState state) => WithdrawRoute();

  String get location => GoRouteData.$location(
        '/withdraw',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WithdrawRewardsRouteExtension on WithdrawRewardsRoute {
  static WithdrawRewardsRoute _fromState(GoRouterState state) =>
      WithdrawRewardsRoute();

  String get location => GoRouteData.$location(
        '/withdraw/rewards',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WithdrawHoldingsRouteExtension on WithdrawHoldingsRoute {
  static WithdrawHoldingsRoute _fromState(GoRouterState state) =>
      WithdrawHoldingsRoute();

  String get location => GoRouteData.$location(
        '/withdraw/holdings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FamilyAppRouteExtension on FamilyAppRoute {
  static FamilyAppRoute _fromState(GoRouterState state) => FamilyAppRoute();

  String get location => GoRouteData.$location(
        '/family-app',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => SettingRoute();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LanguageRouteExtension on LanguageRoute {
  static LanguageRoute _fromState(GoRouterState state) => LanguageRoute();

  String get location => GoRouteData.$location(
        '/setting/language',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CurrencyRouteExtension on CurrencyRoute {
  static CurrencyRoute _fromState(GoRouterState state) => CurrencyRoute();

  String get location => GoRouteData.$location(
        '/setting/currency',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AlertRouteExtension on AlertRoute {
  static AlertRoute _fromState(GoRouterState state) => AlertRoute();

  String get location => GoRouteData.$location(
        '/setting/alert',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AddressBookRouteExtension on AddressBookRoute {
  static AddressBookRoute _fromState(GoRouterState state) => AddressBookRoute();

  String get location => GoRouteData.$location(
        '/setting/address-book',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NoticeRouteExtension on NoticeRoute {
  static NoticeRoute _fromState(GoRouterState state) => NoticeRoute();

  String get location => GoRouteData.$location(
        '/notice',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'bca90a9bd06d32eb8f8253aaf94b8b9b25ba3b6d';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = AutoDisposeProvider<AppRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterRef = AutoDisposeProviderRef<AppRouter>;
String _$appRouterInterceptorHash() =>
    r'd4f42fdf971f53aa5dfcd783841df1e149dbbb16';

/// See also [appRouterInterceptor].
@ProviderFor(appRouterInterceptor)
final appRouterInterceptorProvider =
    AutoDisposeProvider<AppRouterInterceptor>.internal(
  appRouterInterceptor,
  name: r'appRouterInterceptorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appRouterInterceptorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterInterceptorRef = AutoDisposeProviderRef<AppRouterInterceptor>;
String _$appRouterNotifierHash() => r'7f8f1572ff21e2e0b2b73a90eb30d40ed5931748';

/// See also [AppRouterNotifier].
@ProviderFor(AppRouterNotifier)
final appRouterNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AppRouterNotifier, void>.internal(
  AppRouterNotifier.new,
  name: r'appRouterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appRouterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppRouterNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
