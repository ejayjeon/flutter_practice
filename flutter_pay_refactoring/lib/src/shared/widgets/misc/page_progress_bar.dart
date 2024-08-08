import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';

enum ProgressType {
  dot,
  line,
}

class PageProgressBar extends StatefulWidget {
  final Function(int)? onPageChanged;
  final ProgressType type;
  final double width;
  final double height;
  final double circleSize;
  final double space;
  final Color progressColor;
  final Color thumbColor;
  final int currentIndex;
  final int maxLength;
  const PageProgressBar({
    super.key,
    this.onPageChanged,
    this.type = ProgressType.line,
    this.width = 300,
    this.height = 30,
    this.circleSize = 12,
    this.space = 2,
    this.progressColor = AppColor.primary,
    this.thumbColor = AppColor.primaryDark,
    required this.currentIndex,
    required this.maxLength,
  });

  @override
  State<PageProgressBar> createState() => _PageProgressBarState();
}

class _PageProgressBarState extends State<PageProgressBar> {
  List<Widget> itemList = [];

  _refreshList(
    BuildContext context,
  ) {
    itemList = [];
    for (var i = 0; i < widget.maxLength; i++) {
      if (i > 0) {
        itemList.add(SizedBox(
          width: widget.space,
        ));
      }
      itemList.add(
        Stack(
          children: <Widget>[
            if (widget.type == ProgressType.dot) ...[
              ..._dotWidget(i),
            ] else ...[
              _lineWidget(i),
            ],
          ],
        ),
      );
    }
  }

  Widget _lineWidget(int index) {
    return Container(
      width: widget.width / widget.maxLength - widget.space,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.progressColor.withOpacity(
          index <= widget.currentIndex ? 1.0 : 0.2,
        ),
        borderRadius: BorderRadius.circular(
          widget.height / 2,
        ),
      ),
    );
  }

  List<Widget> _dotWidget(int index) {
    return [
      Icon(
        Icons.circle_outlined,
        size: widget.circleSize,
        color: widget.thumbColor,
      ),
      Positioned(
        child: Icon(
          widget.currentIndex == index ? Icons.circle : Icons.circle_outlined,
          size: widget.circleSize,
          color: widget.progressColor,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _refreshList(context);
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: itemList,
      ),
    );
  }
}
