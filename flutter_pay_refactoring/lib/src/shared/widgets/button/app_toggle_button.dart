import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

class AppToggleButton extends StatefulWidget {
  int selectedIndex;
  final List<dynamic> buttonTitles;
  final List<dynamic>? buttonCodes;
  final void Function(int, String)?
      onDestinationSelectedWithTitle; // 버튼 클릭때문에 추가
  final void Function(int)? onDestinationSelected;
  final double buttonWidth;
  final bool needPadding;

  AppToggleButton({
    super.key,
    required this.selectedIndex,
    required this.buttonTitles,
    this.buttonCodes,
    this.onDestinationSelected,
    this.onDestinationSelectedWithTitle,
    this.buttonWidth = 100,
    this.needPadding = true,
  });

  @override
  State<AppToggleButton> createState() => _AppToggleButtonState();
}

class _AppToggleButtonState extends State<AppToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        widget.buttonTitles.length,
        (int index) => Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding: widget.needPadding
                ? index == 0
                    ? EdgeInsets.only(right: 8.w)
                    : index == widget.buttonTitles.length - 1
                        ? EdgeInsets.only(left: 8.w)
                        : context.gap(isSymmetric: true, size: Size(8.sp, 0))
                : null,
            child: SizedBox(
              width: widget.buttonWidth,
              // height: 30,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.selectedIndex = index;
                    // (widget.selectedIndex == index) ? -1 : index; // 삭제되는 부분

                    if (widget.onDestinationSelectedWithTitle != null) {
                      widget.onDestinationSelectedWithTitle!(
                        index,
                        widget.buttonCodes![index],
                      );
                    }

                    if (widget.onDestinationSelected != null) {
                      widget.onDestinationSelected!(index);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: widget.needPadding
                          ? BorderRadius.circular(16)
                          : BorderRadius.zero,
                      side: BorderSide(
                        color: (widget.selectedIndex == index)
                            ? AppColor.primary
                            : AppColor.borderColor,
                      )),
                  backgroundColor: (widget.selectedIndex == index)
                      ? AppColor.primary
                      : AppColor.white,
                ),
                child: Text(
                  widget.buttonTitles[index],
                  style: context.bodyText?.copyWith(
                    color: (widget.selectedIndex == index)
                        ? AppColor.black
                        : AppColor.disableColor,
                    fontWeight: (widget.selectedIndex == index)
                        ? FontWeight.w700
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
