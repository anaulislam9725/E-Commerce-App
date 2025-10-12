import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  static final String path = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        leadingWidth: 110.w,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/left-arrow.png",
            width: 30.w,
            fit: BoxFit.cover,
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimansion.kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment(1.w, 0.8.h),
                    height: 120.w,
                    width: 120.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/profile3.webp"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 34.w,
                        width: 34.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 22.h,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Image.asset(
                        "assets/user.png",
                        fit: BoxFit.cover,
                        height: 20.h,
                        width: 20.w,
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.greyColor,
                          size: 26.h,
                        ),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Image.asset(
                        "assets/call.png",
                        fit: BoxFit.cover,
                        height: 20.h,
                        width: 20.w,
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.greyColor,
                          size: 26.h,
                        ),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Image.asset(
                        "assets/email.png",
                        fit: BoxFit.cover,
                        height: 20.h,
                        width: 20.w,
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                      ),
                    ),

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyColor.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 120.h),
                CustomButton(text: "LOGOUT"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
