import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  const CustomButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32.r),
        onTap: onTap,
        child: Ink(
          height: AppDimansion.buttonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: AppDimansion.kBorderRadius,
            color: AppColors.mainColor,
          ),
          child: Center(child: Text(text ?? "", style: Styles.bodyLarge)),
        ),
      ),
    );
  }
}
