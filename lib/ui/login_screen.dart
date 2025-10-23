import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_app/ui/registration_screen.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static final String path = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SignInController controller = Get.put(SignInController());
  @override
  void dispose() {
    controller.emailController.clear();
    controller.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: AppDimansions.screenWidth,
              decoration: BoxDecoration(color: AppColors.mainColor),
              child: Padding(
                padding: EdgeInsets.only(top: 60.h, left: 50.w),
                child: Text("Sign In", style: Styles.mediumTitle),
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
                      Text("Welcome", style: Styles.largeTitle),

                      Text(
                        "Enter your Email Address to sign in Enjoy your shop:)",
                        style: Styles.bodyMedium.copyWith(
                          color: AppColors.greyColor.withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: " email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => CustomTextField(
                          obscureText: controller.isHide.value,
                          controller: controller.passwordController,
                          hintText: " password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.whiteColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showHide();
                            },
                            icon: Icon(
                              controller.isHide.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialogueBox(context, controller);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: Styles.bodySmall.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      GetBuilder<SignInController>(
                        builder: (controlle) {
                          return CustomButton(
                            onTap: () {
                              controller.signIn();
                            },
                            text: "SIGNIN",
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Styles.extraSmall.copyWith(
                              letterSpacing: -0.5,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpScreen.path);
                            },
                            child: Text(
                              "SignUp",
                              style: Styles.extraSmall.copyWith(
                                color: AppColors.mainColor,
                                letterSpacing: -0.5,
                              ),
                            ),
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

  showDialogueBox(BuildContext context, SignInController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,

          title: Column(
            children: [
              Text(
                "Forgot Password",
                style: Styles.baseStyle.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              Text(
                "Please enter your email address to receive a verification code on your email",
                style: Styles.baseStyle.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              CustomTextField(
                contentPadding: EdgeInsets.only(
                  left: 18.r,
                  top: 14.r,
                  bottom: 14.r,
                ),

                controller: controller.emailController,
                style: TextStyle(color: AppColors.greyColor),
                hintText: "Enter your Email",
                hintColor: AppColors.greyColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.r),
                fillColor: AppColors.mainColor.withValues(alpha: 0.1),
              ),
              SizedBox(height: 30.h),
              CustomButton(
                onTap: () {
                  controller.passwordResed(context);
                },

                borderRadius: BorderRadius.circular(12.r),
                text: "Continue",
              ),
            ],
          ),
        );
      },
    );
  }
}
