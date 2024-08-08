import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin TabControllerMixin<T extends ConsumerStatefulWidget> on State<T>
    implements TickerProvider {
  late TabController _tabController;
  late int tabLengthInit;
  late int selectedIndexInit;
  Ticker? _ticker;

  TabController get tabController => _tabController;

  int get tabLength => tabLengthInit;

  int get selectedIndex => selectedIndexInit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLength, vsync: this);
    log("${tabController.hashCode}", name: "Tab Controller 주소값");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onTapped(int index) {
    setState(() {
      selectedIndexInit = index;
    });
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            '$runtimeType is a SingleTickerProviderStateMixin but multiple tickers were created.'),
        ErrorDescription(
            'A SingleTickerProviderStateMixin can only be used as a TickerProvider once.'),
        ErrorHint(
          'If a State is used for multiple AnimationController objects, or if it is passed to other '
          'objects and those objects might use it more than one time in total, then instead of '
          'mixing in a SingleTickerProviderStateMixin, use a regular TickerProviderStateMixin.',
        ),
      ]);
    }());
    _ticker = Ticker(onTick,
        debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    return _ticker!;
  }

  String describeIdentity(Object? object) =>
      '${objectRuntimeType(object, '<optimized out>')}#${shortHash(object)}';

  String shortHash(Object? object) {
    return object.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0');
  }
}
