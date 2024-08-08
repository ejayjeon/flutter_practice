import 'dart:convert';

import 'package:cookbook/app/const/app_layout.dart';
import 'package:cookbook/app/controller/kcb_controller.dart';
import 'package:cookbook/app/env/config.dart';
import 'package:cookbook/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class KcbPassView extends StatelessWidget {
  const KcbPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: 'KcbPassView',
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.75),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/find.png'),
                  const SizedBox(height: 18.0),
                  const Text('본인 인증을 해주세요'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 56,
                width: Get.width,
                child: ElevatedButton(
                  child: const Text('본인인증'),
                  onPressed: () => Get.toNamed(Routes.KCB_PASS2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class KcbPass extends GetView<KcbController> {
  KcbPass({super.key});

  final settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: true,
  );

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: '본인인증',
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(kcbUrl))),
        initialSettings: settings,
        onWebViewCreated: (controller) {
          KcbController.to.inAppViewController = controller;
          KcbController.to.inAppViewController!.addJavaScriptHandler(
            handlerName: 'message',
            callback: (args) {
              if (args.isNotEmpty) {
                Map<String, dynamic> data = jsonDecode(args[0]);
                KcbController.to.setAuthInfo(data);
              }
            },
          );
        },
        onLoadStop: (controller, url) async {
          await controller.evaluateJavascript(
            source:
                "window.flutter_inappwebview.callHandler('message', setAuthResult());",
          );
        },
        onConsoleMessage: (controller, consoleMessage) {
          debugPrint('onMessage $consoleMessage');
        },
      ),
    );
  }
}
