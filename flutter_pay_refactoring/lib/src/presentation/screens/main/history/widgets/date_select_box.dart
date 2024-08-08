import 'package:flutter/widgets.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/datetime_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class DateSelectBox extends StatelessWidget {
  final void Function(DateTime) onChanged;
  final DateTime date;
  const DateSelectBox({
    super.key,
    required this.onChanged,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(date),
      child: Container(
        padding: context.gap(size: const Size(4, 8)),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1.0, color: AppColor.borderColor),
          color: AppColor.bgGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              date.yy_MM_dd,
              style: context.bodyText?.copyWith(color: AppColor.black),
            ),
            ImageUtil.showImage(
              iconFilePath(fileName: "ic_calendar.png", subFolder: "main"),
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
