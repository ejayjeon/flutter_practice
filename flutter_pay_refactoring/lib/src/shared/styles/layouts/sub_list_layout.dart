import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';

class SubListLayout extends ConsumerWidget {
  final List<IconMenu> datas;
  const SubListLayout({
    super.key,
    required this.datas,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingNotifierProvider.notifier);
    return LayoutBuilder(
      builder: (_, constraints) => ConstrainedBox(
        constraints: constraints,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => Container(
            color: AppColor.white,
            child: ListTile(
              dense: true,
              contentPadding: context.gap(size: Size(24.sp, 24.sp)),
              leading: !datas[index].useCheckItem
                  ? Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.r)),
                        color: AppColor.black,
                      ),
                      alignment: Alignment.center,
                      child: ImageUtil.showImage(
                        datas[index].iconPath,
                      ),
                    )
                  : _customCheckWidget(datas[index].title, state),
              // ImageUtil.showImage(datas[index].iconPath),
              title: Text(
                datas[index].title,
                style: context.titleText?.copyWith(
                  fontSize: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: datas[index].subTitle == null
                  ? const Icon(
                      Icons.keyboard_arrow_right_rounded,
                    )
                  : Text(
                      datas[index].subTitle!,
                      style: context.bodyText,
                    ),
              onTap: () => datas[index].path != null
                  ? context.go(datas[index].path!)
                  : null,
            ),
          ),
          separatorBuilder: (_, idx) => const Divider(
            height: 0,
            color: AppColor.borderColor,
          ),
          itemCount: datas.length,
        ),
      ),
    );
  }

  Widget _customCheckWidget(String title, SettingNotifier state) {
    bool val = false;
    return Checkbox(
      value: val,
      onChanged: (_) {
        val = !val;
        state.toggleLanguageCheckbox(
          SettingLanguageState(
            currentLanguage: Locale(title),
            isEnabled: val,
          ),
        );
      },
    );
  }
}
