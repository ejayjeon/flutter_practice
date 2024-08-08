import 'dart:async';

import 'package:cookbook/app/controller/kcb_controller.dart';
import 'package:cookbook/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  Get.put(KcbController());
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRouter.initPath,
      getPages: AppRouter.pages,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
