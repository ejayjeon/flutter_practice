import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:state_notifier/state_notifier.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColor.primary,
      inputDecorationTheme: _inputTheme,
      appBarTheme: _appBarTheme,
      dialogTheme: _dialogTheme,
      navigationBarTheme: _navigationBarTheme,
      dividerTheme: _dividerTheme,
      tabBarTheme: _tabBarTheme,
      dropdownMenuTheme: _dropdownMenuTheme,
      cardTheme: _cardTheme,
      drawerTheme: _drawerTheme,
      floatingActionButtonTheme: _fabTheme,
    );
  }

  /// [inputDecorationTheme]
  static final _inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColor.bgGrey,
    isDense: true,
    labelStyle: const TextStyle(fontSize: 12),
    hintStyle: const TextStyle(color: AppColor.disableColor, fontSize: 12),
    contentPadding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 18.sp),
    border: _borderStyle,
    enabledBorder: _borderStyle,
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.primary,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
    disabledBorder: _borderStyle,
  );

  static const _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.borderColor,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  );

  /// [appBarTheme]
  static final _appBarTheme = AppBarTheme(
    backgroundColor: AppColor.backGround,
    foregroundColor: AppColor.backGround,
    surfaceTintColor: AppColor.backGround,
    toolbarHeight: kToolbarHeight,
    titleTextStyle: TextStyle(
      color: AppColor.textBlack1,
      fontSize: 18.0.w,
    ),
  );

  /// [dialogTheme]
  static final _dialogTheme = DialogTheme(
    backgroundColor: AppColor.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  );

  /// [DividerThemeData]
  static const _dividerTheme = DividerThemeData(
    color: AppColor.disableColor,
    thickness: 0.5,
    space: 0,
    indent: 0,
  );

  /// [TabBarTheme]
  static final _tabBarTheme = TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerHeight: 1,
    labelPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.w,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.w,
    ),
    unselectedLabelColor: AppColor.textBlack1,
    tabAlignment: TabAlignment.start,
  );

  /// [dropdownMenuTheme]
  static final _dropdownMenuTheme = DropdownMenuThemeData(
    textStyle: TextStyle(
      color: AppColor.textBlack1,
      fontSize: 18.sp,
      height: 2,
    ),
    inputDecorationTheme: _inputTheme,
    menuStyle: const MenuStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(
        AppColor.white,
      ),
      surfaceTintColor: MaterialStatePropertyAll<Color>(
        AppColor.white,
      ),
      shadowColor: MaterialStatePropertyAll<Color>(
        AppColor.white,
      ),
      elevation: MaterialStatePropertyAll<double?>(0),
    ),
  );

  /// [CardTheme]
  static final _cardTheme = CardTheme(
    color: AppColor.white,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0), // 반지름을 설정하여 모서리를 둥글게 만듭니다.
    ),
  );

  static const _navigationBarTheme = NavigationBarThemeData(
    backgroundColor: AppColor.black,
    shadowColor: AppColor.black,
    surfaceTintColor: AppColor.black,
    indicatorColor: Colors.transparent,
  );

  /// [DrawerTheme]
  static const _drawerTheme = DrawerThemeData(
    backgroundColor: AppColor.white,
    shadowColor: AppColor.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  );

  /// [PinTheme]
  static final pinTheme = PinTheme(
    shape: PinCodeFieldShape.circle,
    borderWidth: 1.w,
    disabledColor: AppColor.black,
    selectedColor: AppColor.primary,
    inactiveColor: AppColor.black,
    activeColor: AppColor.black,
    selectedFillColor: AppColor.black,
    activeFillColor: AppColor.black,
    inactiveFillColor: AppColor.black,
  );

  /// [FAB]
  static final _fabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColor.primary,
    elevation: 3,
    // splashColor: AppColor.primary.withOpacity(0.2),
    shape: const CircleBorder(),
  );
}
