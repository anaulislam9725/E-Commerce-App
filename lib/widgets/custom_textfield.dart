import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final bool? readOnly;
  final TextEditingController? controller;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor, hintColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final TextStyle? style;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputDecoration? decoration;
  final TextAlign? textAlign;
  final bool? autofocus;
  const CustomTextField({
    super.key,
    this.autofocus,
    this.style,
    this.onTap,
    this.contentPadding,
    this.borderRadius,
    this.hintColor,
    this.fillColor,
    this.inputFormatters,
    this.readOnly,
    this.controller,
    this.onChanged,
    this.obscureText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.focusedBorder,
    this.enabledBorder,
    this.decoration,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimansion.textFieldHeight,
      child: TextFormField(
        autofocus: autofocus ?? false,
        textAlign: textAlign ?? TextAlign.start,
        onTap: onTap,
        inputFormatters: inputFormatters,
        readOnly: readOnly ?? false,
        controller: controller,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        keyboardType: keyboardType,
        cursorColor: AppColors.mainColor,
        cursorHeight: 18.h,

        style: style ?? Styles.bodySmall,
        decoration:
            decoration ??
            InputDecoration(
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.w),
              hintText: hintText ?? hintText,
              hintStyle: Styles.bodySmall.copyWith(
                color: hintColor ?? AppColors.whiteColor.withValues(alpha: 0.5),
              ),
              focusedBorder:
                  focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    borderSide: BorderSide(color: AppColors.mainColor),
                  ),
              enabledBorder:
                  enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    borderSide: BorderSide.none,
                  ),
              fillColor:
                  fillColor ?? AppColors.greyColor.withValues(alpha: 0.8),
              filled: true,

              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
      ),
    );
  }
}
