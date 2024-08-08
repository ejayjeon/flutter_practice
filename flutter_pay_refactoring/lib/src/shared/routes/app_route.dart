part of 'router.dart';

abstract class Branch extends StatefulShellBranchData {
  final GlobalKey<NavigatorState> navigatorKey;
  const Branch(this.navigatorKey);
}

abstract class RoutePage extends GoRouteData {
  final Widget child;
  final String? id;

  const RoutePage({
    required this.child,
    this.id,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return child;
  }
}

abstract class DetailRoutePage extends GoRouteData {
  final Widget child;
  final String id;

  const DetailRoutePage({
    required this.child,
    required this.id,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return child;
  }
}

class AppRoute {
  AppRoute._();

  static const splash = "/splash";
  static const login = "/login";
  static const findInfo = "/find-info";
  static const pinCheck = "/pin-check";
  static const resetPin = "/reset-pin";

  /// [앱 쉘이 유지되어야 하는 영역(Bottom Navigation, AppBar 존재)]
  static const home = "/home";
  static const qr = "/qr";
  static const qrPayment = "/qr-payment";
  static const history = "/history";
  static const payment = "/payment";
  // static const receive = "/receive";

  /// [서브 쉘이 유지되어야 하는 영역]
  static const account = "/account";
  static const accountInfo = "/account-info";

  static const withdraw = "/withdraw";
  static const withdrawHoldings = "holdings";
  static const withdrawRewards = "rewards";
  static const storeMap = "/store-map";
  static const familyApp = "/family-app";
  static const setting = "/setting";
  static const notice = "/notice";

  static const language = "language";
  static const currency = "currency";
  static const alert = "alert";
  static const addressBook = "address-book";
}

class NavigatorKey {
  NavigatorKey._();

  static final _routerKey = GlobalKey<NavigatorState>();
  static final _appShellKey = GlobalKey<NavigatorState>();
  static final _subShellKey = GlobalKey<NavigatorState>();
  static final _homeKey = GlobalKey<NavigatorState>();
  static final _qrKey = GlobalKey<NavigatorState>();
  static final _historyKey = GlobalKey<NavigatorState>();
  static final _paymentKey = GlobalKey<NavigatorState>();

  //////// 서브메뉴 ////////////
  static final _accountKey = GlobalKey<NavigatorState>();

  static final _withdrawKey = GlobalKey<NavigatorState>();
  // static final _storeMapKey = GlobalKey<NavigatorState>();
  static final _familyAppKey = GlobalKey<NavigatorState>();
  static final _settingKey = GlobalKey<NavigatorState>();
  static final _noticeKey = GlobalKey<NavigatorState>();
}

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends RoutePage {
  static const path = AppRoute.splash;
  SplashRoute() : super(child: const SplashScreen());
}

@TypedGoRoute<LoginRoute>(
  path: LoginRoute.path,
  routes: [
    TypedGoRoute<AfterLoginRoute>(path: ':id'),
  ],
)
class LoginRoute extends RoutePage {
  static const path = AppRoute.login;
  LoginRoute() : super(child: const LoginScreen());
}

/// id: success or fail
class AfterLoginRoute extends RoutePage {
  @override
  // ignore: overridden_fields
  final String id;
  AfterLoginRoute(this.id)
      : super(
          child: AfterLoginScreen(),
          id: id,
        );
}

/// [정보 찾기]
@TypedGoRoute<FindInfoRoute>(
  path: FindInfoRoute.path,
  routes: [
    TypedGoRoute<FindInfoDetailRoute>(path: ':id'),
  ],
)
class FindInfoRoute extends RoutePage {
  static const path = AppRoute.findInfo;
  FindInfoRoute() : super(child: const FindInfoScreen());
}

/// id: id or password
class FindInfoDetailRoute extends RoutePage {
  final String id;
  FindInfoDetailRoute(this.id)
      : super(
          child: FindInfoDetailScreen(id: id),
        );
}

@TypedGoRoute<ResetPinRoute>(path: ResetPinRoute.path)
class ResetPinRoute extends RoutePage {
  static const path = AppRoute.resetPin;
  ResetPinRoute() : super(child: const ResetPinScreen());
}

/// [핀번호 체크]
@TypedGoRoute<PinCheckRoute>(path: PinCheckRoute.path)
class PinCheckRoute extends RoutePage {
  static const path = AppRoute.pinCheck;
  PinCheckRoute() : super(child: const PinCheckScreen());
}

///////////////////////
@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [
        TypedGoRoute<HomeRoute>(path: HomeRoute.path),
      ],
    ),
    TypedStatefulShellBranch<QrBranch>(
      routes: [
        TypedGoRoute<QRPaymentRoute>(
          path: QRPaymentRoute.path,
        ),
      ],
    ),
    TypedStatefulShellBranch<HistoryBranch>(
      routes: [
        TypedGoRoute<HistoryRoute>(
          path: HistoryRoute.path,
          // routes: [
          //   TypedGoRoute<HistoryDetailRoute>(path: ":id"),
          // ],
        ),
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  static final $navigatorKey = NavigatorKey._appShellKey;
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return Main(navigationShell: navigationShell);
  }
}

class HomeBranch extends Branch {
  HomeBranch() : super(NavigatorKey._homeKey);
}

class QrBranch extends Branch {
  QrBranch() : super(NavigatorKey._qrKey);
}

class HistoryBranch extends Branch {
  HistoryBranch() : super(NavigatorKey._historyKey);
}

///////////////////
class HomeRoute extends RoutePage {
  static const path = AppRoute.home;
  HomeRoute() : super(child: const HomeScreen());
}

@TypedGoRoute<QrRoute>(path: QrRoute.path)
class QrRoute extends RoutePage {
  static const path = AppRoute.qr;
  QrRoute() : super(child: const QrScreen());
}

class QRPaymentRoute extends RoutePage {
  static const path = AppRoute.qrPayment;
  QRPaymentRoute() : super(child: const QRPaymentScreen());
}

class HistoryRoute extends RoutePage {
  static const path = AppRoute.history;
  HistoryRoute() : super(child: const HistoryScreen());
}

// @TypedGoRoute<HistoryDetailRoute>(path: HistoryDetailRoute.path)
// class HistoryDetailRoute extends RoutePage {
//   static const path = '${HistoryRoute.path}/details';
//   HistoryDetailRoute() : super(child: const HistoryDetailScreen());
// }
@TypedGoRoute<HistoryDetailRoute>(path: HistoryDetailRoute.path)
class HistoryDetailRoute extends GoRouteData {
  static const path = '${HistoryRoute.path}/details';
  HistoryDetailRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final data = state.extra as ParamList;
    return HistoryDetailScreen(data: data);
  }
}

@TypedGoRoute<PaymentRoute>(path: PaymentRoute.path)
class PaymentRoute extends RoutePage {
  static const path = AppRoute.payment;
  PaymentRoute() : super(child: const PaymentScreen());
}

/////////////////////////////////////////////////////////

@TypedStatefulShellRoute<SubShellRoute>(
  branches: [
    TypedStatefulShellBranch<AccountBranch>(
      routes: [
        TypedGoRoute<AccountRoute>(path: AccountRoute.path),
        TypedGoRoute<PinCheckRoute>(path: PinCheckRoute.path)
      ],
    ),
    // TypedStatefulShellBranch<HistoryBranch>(
    //   routes: [
    //     TypedGoRoute<HistoryRoute>(path: HistoryRoute.path),
    //   ],
    // ),
    TypedStatefulShellBranch<WithdrawBranch>(
      routes: [
        TypedGoRoute<WithdrawRoute>(
          path: WithdrawRoute.path,
          routes: [
            TypedGoRoute<WithdrawRewardsRoute>(
              path: WithdrawRewardsRoute.path,
            ),
            TypedGoRoute<WithdrawHoldingsRoute>(
              path: WithdrawHoldingsRoute.path,
            ),
          ],
        ),
      ],
    ),
    // TypedStatefulShellBranch<StoreMapBranch>(
    //   routes: [
    //     TypedGoRoute<StoreMapRoute>(path: StoreMapRoute.path),
    //   ],
    // ),
    TypedStatefulShellBranch<FamilyAppBranch>(
      routes: [
        TypedGoRoute<FamilyAppRoute>(path: FamilyAppRoute.path),
      ],
    ),
    TypedStatefulShellBranch<SettingBranch>(
      routes: [
        TypedGoRoute<SettingRoute>(
          path: SettingRoute.path,
          routes: [
            TypedGoRoute<LanguageRoute>(path: LanguageRoute.path),
            TypedGoRoute<CurrencyRoute>(path: CurrencyRoute.path),
            TypedGoRoute<AlertRoute>(path: AlertRoute.path),
            TypedGoRoute<AddressBookRoute>(path: AddressBookRoute.path),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<NoticeBranch>(
      routes: [
        TypedGoRoute<NoticeRoute>(path: NoticeRoute.path),
      ],
    ),
  ],
)
class SubShellRoute extends StatefulShellRouteData {
  static final $navigatorKey = NavigatorKey._subShellKey;
  const SubShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return Sub(navigationShell: navigationShell);
  }
}

class AccountBranch extends Branch {
  AccountBranch() : super(NavigatorKey._accountKey);
}

// class HistoryBranch extends Branch {
//   HistoryBranch() : super(NavigatorKey._historyKey);
// }

class WithdrawBranch extends Branch {
  WithdrawBranch() : super(NavigatorKey._withdrawKey);
}

// class StoreMapBranch extends Branch {
//   StoreMapBranch() : super(NavigatorKey._storeMapKey);
// }

class FamilyAppBranch extends Branch {
  FamilyAppBranch() : super(NavigatorKey._familyAppKey);
}

class SettingBranch extends Branch {
  SettingBranch() : super(NavigatorKey._settingKey);
}

class NoticeBranch extends Branch {
  NoticeBranch() : super(NavigatorKey._noticeKey);
}

/////// 서브 메뉴 라우트
class AccountRoute extends RoutePage {
  static const path = AppRoute.accountInfo;
  AccountRoute() : super(child: const AccountScreen());
}

// class HistoryRoute extends RoutePage {
//   static const path = AppRoute.history;
//   HistoryRoute() : super(child: const HistoryScreen());
// }

class WithdrawRoute extends RoutePage {
  static const path = AppRoute.withdraw;
  WithdrawRoute() : super(child: const WithdrawScreen());
}

class WithdrawHoldingsRoute extends RoutePage {
  static const path = AppRoute.withdrawHoldings;
  WithdrawHoldingsRoute() : super(child: const WithdrawHoldingsScreen());
}

class WithdrawRewardsRoute extends RoutePage {
  static const path = AppRoute.withdrawRewards;
  WithdrawRewardsRoute() : super(child: const WithdrawRewardsScreen());
}

// class StoreMapRoute extends RoutePage {
//   static const path = AppRoute.storeMap;
//   StoreMapRoute() : super(child: const StoreMapScreen());
// }

class FamilyAppRoute extends RoutePage {
  static const path = AppRoute.familyApp;
  FamilyAppRoute() : super(child: const FamilyAppScreen());
}

class SettingRoute extends RoutePage {
  static const path = AppRoute.setting;
  SettingRoute() : super(child: const SettingScreen());
}

class NoticeRoute extends RoutePage {
  static const path = AppRoute.notice;
  NoticeRoute() : super(child: const NoticeScreen());
}

class LanguageRoute extends RoutePage {
  static const path = AppRoute.language;
  LanguageRoute() : super(child: const LanguageScreen());
}

class CurrencyRoute extends RoutePage {
  static const path = AppRoute.currency;
  CurrencyRoute() : super(child: const CurrencyScreen());
}

class AlertRoute extends RoutePage {
  static const path = AppRoute.alert;
  AlertRoute() : super(child: const AlertScreen());
}

class AddressBookRoute extends RoutePage {
  static const path = AppRoute.addressBook;
  AddressBookRoute() : super(child: const AddressBookScreen());
}
