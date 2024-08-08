import 'package:cookbook/app/const/app_dialog.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class KcbController extends GetxController {
  static KcbController get to => Get.put(KcbController());
  InAppWebViewController? inAppViewController;
  var dio = Dio();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    inAppViewController!.dispose();
  }

  void setAuthInfo(Map<String, dynamic> data) async {
    try {
      if (data['RSLT_CD'] != 'B000') {
        appDialog(Get.context!, '본인 인증에 실패하였습니다. 다시 시도해주세요');
        throw ('RSLT_CD != B000');
      }
      final res = await dio.post(
        '/members/mobile/exists',
        data: {
          'mobile': data['TEL_NO'],
        },
      );

      if (res.data['count'] != 0) {
        appDialog(Get.context!, '이미 가입된 번호 입니다.');
        throw ('moblie number already exists');
      }
      // name = data['RSLT_NAME'];
      // mobile = data['TEL_NO'];
      // birthday = data['RSLT_BIRTHDAY'];
      // currentStep.value++;
    } catch (e) {
      print(e);
    }
    Get.back();
  }
}
