import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? onDestinationSelected;
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        _navigationDestination(
          iconPath: iconFilePath(fileName: "ic_home.svg", subFolder: "main"),
        ),
        _navigationDestination(
          iconPath: iconFilePath(fileName: "ic_scan.svg", subFolder: "main"),
        ),
        _navigationDestination(
          iconPath: iconFilePath(fileName: "ic_history.svg", subFolder: "main"),
        ),
      ],
    );
  }

  Widget _navigationDestination({
    String? label,
    Size? iconSize,
    Color? color,
    required String iconPath,
  }) {
    return NavigationDestination(
      icon: ImageUtil.showImage(
        iconPath,
        width: iconSize?.width,
        height: iconSize?.height,
        color: AppColor.disableColor,
        fit: BoxFit.fill,
      ),
      selectedIcon: ImageUtil.showImage(
        iconPath,
        width: iconSize?.width,
        height: iconSize?.height,
        color: color ?? AppColor.primary,
        fit: BoxFit.fill,
      ),
      label: label ?? "",
    );
  }
}
