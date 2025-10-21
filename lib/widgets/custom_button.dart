import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32.r),
        onTap: onTap,
        child: Ink(
          height: height ?? AppDimansions.buttonHeight,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? AppDimansions.kBorderRadius,
            color: AppColors.mainColor,
          ),
          child: Center(
            child: Text(
              text,
              style: Styles.bodyLarge.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.widgetColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
