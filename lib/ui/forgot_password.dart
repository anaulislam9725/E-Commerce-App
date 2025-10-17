import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static final String path = "ForgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose;
    super.dispose();
  }

  Future passwordResed() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password reset link send! check your email"),
          );
        },
      );
      emailController.clear();
    } on FirebaseAuthException catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.message.toString()));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.widgetColor,
      body: Padding(
        padding: AppDimansion.kDefaultPadding,
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
                controller: emailController,
                style: TextStyle(color: AppColors.greyColor),
                hintText: "Email",
                hintColor: AppColors.greyColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.r),
                fillColor: AppColors.mainColor.withValues(alpha: 0.1),
              ),
              SizedBox(height: 60.h),
              CustomButton(
                onTap: () {
                  passwordResed();
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
