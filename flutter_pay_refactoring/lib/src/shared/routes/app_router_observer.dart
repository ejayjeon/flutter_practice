part of 'router.dart';

class AppRouterObserver extends NavigatorObserver {
  void _routerLog({
    Route? newRoute,
    Route? previousRoute,
    String? routeType,
  }) {
    log(
      'new: ${newRoute?.settings.name}\nprevious: ${previousRoute?.settings.name}\ntype: $routeType',
      name: "Router Observer",
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _routerLog(
      newRoute: route,
      previousRoute: previousRoute,
      routeType: 'Push',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // super.didPop(route, previousRoute);

    if (Navigator.of(route.navigator!.context).canPop()) {
      Navigator.of(route.navigator!.context).pop();
    } else {
      // Navigator.of(route.navigator!.context).push(route);
      // IntlPhoneNumberKit pkg에서 에러가 발생함
    }
    _routerLog(
      newRoute: route,
      previousRoute: previousRoute,
      routeType: 'Pop',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // super.didReplace(newRoute, oldRoute);
    _routerLog(
      newRoute: newRoute,
      previousRoute: oldRoute,
      routeType: 'Replace',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _routerLog(
      newRoute: route,
      previousRoute: previousRoute,
      routeType: 'Remove',
    );
  }
}
