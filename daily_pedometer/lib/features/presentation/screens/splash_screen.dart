import 'package:daily_pedometer/common/configs/const.dart';
import 'package:daily_pedometer/externals/storage/storage_provider.dart';
import 'package:daily_pedometer/features/pedometer/data/repositories/pedometer_repository_impl.dart';
import 'package:daily_pedometer/features/pedometer/services/pedometer_service.dart';
import 'package:daily_pedometer/features/permissions/domain/notifiers/permission_notifier.dart';
import 'package:daily_pedometer/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(permissionNotifierProvider.notifier);
      final storage = ref.read(storageProvider);
      final pedometer = ref.read(pedometerRepositoryProvider);

      /// 최초 접근인지 확인
      /// 최초 접근 = 권한 확인을 안한 사람
      /// 이 외에도, 디바이스 넘버링을 저장해서, 해당 디바이스를 식별할 수 있으나 이번엔 사용 안함
      // final firstTime = await storage.get(key: isFirstTime) ?? true;
      // if (!firstTime) {
      //   if (context.mounted) {
      //     context.pushReplacement(AppRoutes.targetSettings);
      //   }
      // }

      while (!ref.read(permissionNotifierProvider).allPermissionsGranted) {
        await notifier.requestPermissions([
          Permission.location,
          Permission.activityRecognition,
        ]);
      }

      await storage.set(key: isFirstTime, data: false);
      if (context.mounted) {
        if (pedometer.getTargetedSteps() == 0) {
          context.pushReplacement(AppRoutes.targetSettings);
        } else {
          context.pushReplacement(AppRoutes.pedometer);
        }
      }
    });

    return const Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Text(
          "Daily Pedometer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
