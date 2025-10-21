import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/registation_controller.dart';

import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/social_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  static final String path = "/SignUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final RegistretionController registretionController = Get.put(
      RegistretionController(),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: AppDimansions.screenHeight * .35,
              width: AppDimansions.screenWidth,
              decoration: BoxDecoration(color: AppColors.mainColor),
              child: Padding(
                padding: EdgeInsets.only(top: 90.h, right: 20.w, left: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48.w,
                      width: 48.w,
                      decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.whiteColor,
                            size: 25.h,
                          ),
                        ),
                      ),
                    ),

                    Text("SIGN UP", style: Styles.mediumTitle),
                    Container(
                      margin: EdgeInsets.only(right: 24.w),
                      height: 48.h,
                      width: 48.h,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 210.h,
            right: 0,
            left: 0,
            bottom: 0,

            child: SingleChildScrollView(
              child: Container(
                height: AppDimansions.screenHeight,
                width: AppDimansions.screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35.r),
                  ),
                ),
                child: Padding(
                  padding: AppDimansions.kDefaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text("Create Account", style: Styles.largeTitle),

                      Text(
                        "Enter your Emaill and Password for sign up.",
                        style: Styles.bodyMedium.copyWith(
                          color: AppColors.greyColor.withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomTextField(
                        controller: registretionController.emailController,
                        hintText: " email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => CustomTextField(
                          obscureText: registretionController.isHide.value,
                          controller: registretionController.passwordController,
                          hintText: " password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.whiteColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              registretionController.showHide();
                            },
                            icon: Icon(
                              registretionController.isHide.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h),
                      CustomButton(
                        onTap: () {
                          registretionController.signUp(context);
                        },
                        text: "SIGN UP",
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "aleady have an account",
                            style: Styles.extraSmall,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Signin",
                              style: Styles.extraSmall.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 1.5.h,
                            width: 150.w,
                            color: AppColors.greyColor.withValues(alpha: 0.4),
                          ),
                          Text(
                            "OR",
                            style: Styles.baseStyle.copyWith(
                              color: AppColors.mainColor.withValues(alpha: 0.7),
                            ),
                          ),
                          Container(
                            height: 1.5.h,
                            width: 150.w,
                            color: AppColors.greyColor.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialContainer(
                            onTap: () {},
                            image: Image.asset("assets/fb.png"),
                          ),
                          SocialContainer(
                            onTap: () {},
                            image: Image.asset("assets/google.png"),
                          ),
                          SocialContainer(
                            onTap: () {},
                            image: Image.asset("assets/twitter.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
