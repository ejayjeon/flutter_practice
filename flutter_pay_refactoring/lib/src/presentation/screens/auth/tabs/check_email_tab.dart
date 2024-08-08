import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/presentation/screens/auth/widgets/custom_text_field.dart';
import 'package:sketch_pay/src/presentation/screens/auth/widgets/info_text_widget.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/mixins/tab_controller_mixin.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';

class CheckEmailTab extends ConsumerWidget {
  final TabController controller;
  const CheckEmailTab({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(resetPinProvider.notifier);
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: constraints,
        child: Column(
          children: <Widget>[
            const InfoTextWidget(
              info: "회원님이 *스케치 월렛*에 등록하신 *회원전용 아이디*를 *입력*해 주세요",
            ),
            Expanded(
              child: Form(
                key: notifier.emailFormKey,
                child: CustomTextField(
                  controller: notifier.emailController,
                  hintText: "이메일을 입력해 주세요",
                  labelText: "이메일",

                  /// 입력이 될 때마다 validate를 체크
                  onChanged: (String? value) => notifier.emailValidator(value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
