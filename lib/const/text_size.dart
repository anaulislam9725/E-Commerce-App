import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class Styles {
  static final String _defaultFontFamily = "RobotoMono";
  static final String secondaryFontFamily = "Raleway";

  static TextStyle baseStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle largeTitle = TextStyle(
    color: AppColors.mainColor,
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle mediumTitle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle smallTitle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle bodyLarge = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle bodyMedium = TextStyle(
    color: AppColors.greyColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle bodySmall = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _defaultFontFamily,
  );
  static TextStyle extraSmall = TextStyle(
    color: AppColors.greyColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _defaultFontFamily,
  );
}
