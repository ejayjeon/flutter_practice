import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/models/model.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onClosePressed;
  const AppDrawer({
    super.key,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    final drawerItem = [
      IconMenu(
        title: "계정 정보",
        iconPath:
            iconFilePath(fileName: "ic_account.svg", subFolder: "sidebar"),
        path: "/account",
      ),
      IconMenu(
        title: "거래 내역",
        iconPath:
            iconFilePath(fileName: "ic_history.svg", subFolder: "sidebar"),
        path: "/history",
      ),
      IconMenu(
        title: "자산 인출",
        iconPath:
            iconFilePath(fileName: "ic_withdraw.svg", subFolder: "sidebar"),
        path: "/withdraw",
      ),
      IconMenu(
        title: "스토어 검색",
        iconPath: iconFilePath(fileName: "ic_map.svg", subFolder: "sidebar"),
        path: "/store-map",
      ),
      IconMenu(
        title: "패밀리 앱",
        iconPath:
            iconFilePath(fileName: "ic_family_app.svg", subFolder: "sidebar"),
        path: "/family-app",
      ),
      IconMenu(
        title: "앱 설정",
        iconPath:
            iconFilePath(fileName: "ic_setting.svg", subFolder: "sidebar"),
        path: "/setting",
      ),
      IconMenu(
        title: "공지 및 문의",
        iconPath: iconFilePath(fileName: "ic_notice.svg", subFolder: "sidebar"),
        path: "/notice",
      ),
    ];
    return Drawer(
      semanticLabel: "사이드바",
      width: context.width,
      child: Padding(
        padding: context.gap(size: Size(32.sp, 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, title: "Sketch Pay", onPressed: onClosePressed),
            _mid(context, accntCdTitle: "회원코드: 7TOVTF", storeTitle: "S-Store"),
            _bottomTitle(context),
            _bottomList(context, items: drawerItem),
          ],
        ),
      ),
    );
  }

  Widget _header(
    BuildContext context, {
    required String title,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageUtil.showImage(
                "assets/icons/sidebar/ic_logo.png",
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: 12.sp,
              ),
              Text(
                title,
                style: context.headerText?.copyWith(
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _mid(
    BuildContext context, {
    required String accntCdTitle,
    required String storeTitle,
    VoidCallback? onCopyPressed,
    VoidCallback? onSharePressed,
    VoidCallback? onStorePressed,
    bool isConnected = true,
  }) {
    return Container(
      padding: context.gap(size: Size(18.sp, 24.sp)),
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Column(
        children: <Widget>[
          _midStatusWidget(
            context,
            color: AppColor.disableDarkColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  accntCdTitle,
                  style: context.titleText?.copyWith(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: <Widget>[
                    _tabIcon(
                      semanticTitle: "복사버튼",
                      iconPath: "assets/icons/sidebar/ic_copy.svg",
                      onPressed: onCopyPressed,
                      color: AppColor.white,
                    ),
                    _tabIcon(
                      semanticTitle: "공유버튼",
                      iconPath: "assets/icons/sidebar/ic_share.svg",
                      onPressed: onSharePressed,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _midStatusWidget(
            context,
            color: isConnected ? AppColor.primary : AppColor.disableColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  isConnected ? storeTitle : "S-Store Connect",
                  style: context.titleText?.copyWith(
                    color: isConnected ? AppColor.black : AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _tabIcon(
                  semanticTitle: "스토어이동버튼",
                  icon: Icons.keyboard_arrow_right_rounded,
                  onPressed: onStorePressed,
                  color: isConnected ? AppColor.black : AppColor.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _midStatusWidget(
    BuildContext context, {
    Color? color,
    required Widget child,
  }) {
    return Container(
      padding: context.gap(size: Size(12.sp, 8.sp)),
      margin: context.gap(size: Size(12.sp, 8.sp)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: child,
    );
  }

  Widget _tabIcon({
    String? semanticTitle,
    String? iconPath,
    IconData? icon,
    VoidCallback? onPressed,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: iconPath != null
          ? ImageUtil.showImage(
              iconPath,
              color: color,
            )
          : Icon(icon),
    );
  }

  Widget _bottomTitle(BuildContext context) {
    return Container(
      padding: context.gap(
        size: Size(0, 24.sp),
      ),
      child: Text(
        "메뉴",
        style: context.titleText?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _bottomList(BuildContext context, {required List<IconMenu> items}) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: items.length,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (_, index) => _buildListTile(
          context,
          semanticTitle: items[index].title,
          iconPath: items[index].iconPath,
          title: items[index].title,
          onPressed: () => context.go(items[index].path!),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    String? semanticTitle,
    required String iconPath,
    required String title,
    VoidCallback? onPressed,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.r)),
          color: AppColor.primary,
        ),
        alignment: Alignment.center,
        child: ImageUtil.showImage(iconPath),
      ),
      title: Text(title,
          style: context.titleText?.copyWith(
            fontSize: 16,
            color: AppColor.black,
            fontWeight: FontWeight.w700,
          )),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
      onTap: onPressed,
    );
  }
}
