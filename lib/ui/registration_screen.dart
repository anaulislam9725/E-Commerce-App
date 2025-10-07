import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:e_commerce_app/ui/user_form.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/social_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  static final String path = "/SignUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isHide = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signUp() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      var authCredential = credential.user;

      if (authCredential!.uid.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, UserForm.path);
        emailController.clear();
        passwordController.clear();
      } else {
        Fluttertoast.showToast(msg: "Something is worng");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height.h;
    final double width = MediaQuery.of(context).size.width.w;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: height * .35,
              width: width,
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
                height: height * .70,
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35.r),
                  ),
                ),
                child: Padding(
                  padding: AppDimansion.kDefaultPadding,
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
                        controller: emailController,
                        hintText: " email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        obscureText: isHide,
                        controller: passwordController,
                        hintText: " password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.whiteColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHide = !isHide;
                            });
                          },
                          icon: Icon(
                            isHide ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h),
                      CustomButton(
                        onTap: () {
                          signUp();
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
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                BottomNavController.path,
                              );
                            },
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
