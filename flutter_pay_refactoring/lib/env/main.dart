import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/env/app.dart';
import 'package:sketch_pay/env/env.dart';
import 'package:sketch_pay/src/shared/utils/misc_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String envType = const String.fromEnvironment("ENV_TYPE");
  String ssoUrl = const String.fromEnvironment("SSO_URL");
  String vapgUrl = const String.fromEnvironment("VAPG_URL");
  String payUrl = const String.fromEnvironment("PAY_URL");
  Env.initialize(
    envType: envType,
    ssoUrl: ssoUrl,
    vapgUrl: vapgUrl,
    payUrl: payUrl,
  );
  runApp(
    const ProviderScope(
      observers: [],
      child: App(),
    ),
  );
}
