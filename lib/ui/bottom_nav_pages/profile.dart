import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/profile_controller.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  static final String path = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        leadingWidth: 110.w,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppDimansions.kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<ProfileController>(
                  builder: (controller) {
                    return Container(
                      height: 120.h,
                      width: 120.h,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          controller.image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      width: 2.5,
                                      color: Colors.black.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(controller.image!),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      width: 2.5.w,
                                      color: Colors.black.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/profile3.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          IconButton(
                            onPressed: () {
                              ShowImagePickarOption(context);
                            },
                            icon: Container(
                              height: 32.h,
                              width: 32.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[800],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 40.h),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users_form_data")
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshots) {
                    var data = snapshots.data;

                    // Get current user info
                    if (data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshots.hasData || !snapshots.data!.exists) {
                      // 🟡 Document not found
                      return const Text('No data found for this user');
                    }
                    // ------------------- show user info in the textfield--------------

                    profileController.nameController.text = data?["name"] ?? "";
                    profileController.numberController.text =
                        data?["phone"] ?? "";

                    profileController.emailController.text = FirebaseAuth
                        .instance
                        .currentUser!
                        .email
                        .toString();

                    /* alert dialog er moddhe data show koranor jonno
                        1 way. controller.text =  data["name".toString()];
                        2 way. controller.text =  nameController!.text;

                        */
                    // ------------------- show user info in the textfield--------------
                    return Column(
                      children: [
                        GetBuilder<ProfileController>(
                          builder: (controller) {
                            return CustomTextField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              controller: profileController.nameController,
                              decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 130.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/user.png",
                                          fit: BoxFit.cover,
                                          height: 18.h,
                                          width: 18.w,
                                          color: AppColors.blackColor
                                              .withValues(alpha: 0.7),
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          "Username",
                                          style: Styles.smallTitle.copyWith(
                                            fontSize: 18.sp,
                                            color: AppColors.blackColor
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showDialogueBox(
                                      context: context,
                                      userInfo: "name",
                                      controller:
                                          profileController.nameController,
                                      profileController: profileController,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.greyColor,
                                    size: 26.h,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12.h),
                        GetBuilder<ProfileController>(
                          builder: (controller) {
                            return CustomTextField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              controller: profileController.numberController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: SizedBox(
                                    width: 110.w,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/call.png",
                                          fit: BoxFit.cover,
                                          height: 18.h,
                                          width: 18.w,
                                          color: AppColors.blackColor
                                              .withValues(alpha: 0.7),
                                        ),
                                        SizedBox(width: 14.w),
                                        Text(
                                          "Number",
                                          style: Styles.smallTitle.copyWith(
                                            fontSize: 18.sp,
                                            color: AppColors.blackColor
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 8.h),

                                  child: IconButton(
                                    onPressed: () {
                                      profileController.controller.text =
                                          profileController
                                              .numberController
                                              .text
                                              .toString();
                                      showDialogueBox(
                                        context: context,
                                        userInfo: "number",
                                        controller:
                                            profileController.numberController,
                                        profileController: profileController,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.greyColor,
                                      size: 26.h,
                                    ),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12.h),
                        GetBuilder<ProfileController>(
                          builder: (controller) {
                            return CustomTextField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              controller: profileController.emailController,
                              decoration: InputDecoration(
                                // prefixIcon: Icon(Icons.email, size: 28),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: SizedBox(
                                    width: 100.w,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/email.png",
                                          fit: BoxFit.cover,
                                          height: 20.h,
                                          width: 20.w,
                                          color: AppColors.blackColor
                                              .withValues(alpha: 0.7),
                                        ),
                                        SizedBox(width: 14.w),
                                        Text(
                                          "Email",
                                          style: Styles.smallTitle.copyWith(
                                            fontSize: 18.sp,
                                            color: AppColors.blackColor
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.greyColor.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 90.h),
                CustomButton(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAll(LoginScreen());
                  },
                  text: "LOGOUT",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ShowImagePickarOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.bottomColor,
      context: context,
      builder: (builder) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,

          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      profileController.pickImageFormGallery(context);
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.image, size: 70, color: Colors.white),
                          Text(
                            "Gallery",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      profileController.pickImageFormCamera(context);
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 70, color: Colors.white),
                          Text("Camera", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showDialogueBox({
    required BuildContext context,
    required String userInfo, // name, phone
    required TextEditingController controller, // int a
    required ProfileController profileController,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit"),
          actions: [
            // print
            // Text(controller.text.toString()),
            TextField(controller: controller),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.redColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      Fluttertoast.showToast(msg: "$userInfo is required");
                    } else {
                      Get.put(ProfileController()).updateData(
                        context: context,
                        key: userInfo,
                        value: controller.text,
                      );
                    }
                    // context,userInfo,controller.text
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
