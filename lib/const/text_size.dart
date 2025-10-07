import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class Styles {
  static TextStyle baseStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle largeTitle = TextStyle(
    color: AppColors.mainColor,
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle mediumTitle = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallTitle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bodyLarge = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyMedium = TextStyle(
    color: AppColors.greyColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodySmall = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle extraSmall = TextStyle(
    color: AppColors.greyColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
}
