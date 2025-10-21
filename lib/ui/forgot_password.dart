import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/forgot_pass_controller.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static final String path = "ForgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final ForgotPassController forgotPassController = Get.put(
      ForgotPassController(),
    );
    return Scaffold(
      backgroundColor: AppColors.widgetColor,
      body: Padding(
        padding: AppDimansions.kDefaultPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email. and we will send you a password reset link",
                style: Styles.baseStyle.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              CustomTextField(
                contentPadding: EdgeInsets.only(
                  left: 18.r,
                  top: 14.r,
                  bottom: 14.r,
                ),
                controller: forgotPassController.emailController,
                style: TextStyle(color: AppColors.greyColor),
                hintText: "Email",
                hintColor: AppColors.greyColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.r),
                fillColor: AppColors.mainColor.withValues(alpha: 0.1),
              ),
              SizedBox(height: 60.h),
              CustomButton(
                onTap: () {
                  forgotPassController.passwordResed(context);
                },
                width: 160.w,
                borderRadius: BorderRadius.circular(12.r),
                text: "Reset passowrd",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
