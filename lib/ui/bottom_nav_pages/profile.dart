import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatefulWidget {
  static final String path = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final controller = TextEditingController();
  // updateData('name','anaul');
  //  updateData('phone','017*****65');
  updateData(String key, String value) {
    CollectionReference collectionData = FirebaseFirestore.instance.collection(
      "users_form_data",
    );
    return collectionData
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          key: value,

          // "name": nameController?.text,
          // "phone": numberController?.text,
        })
        // ignore: use_build_context_synchronously
        .then((onValue) {
          Navigator.pop(context);
          Fluttertoast();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        leadingWidth: 110.w,
        // title: Text("print-----${}"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
                // ignore: avoid_print
                Center(
                  child: Container(
                    alignment: Alignment(1.w, 0.8.h),
                    height: 120.w,
                    width: 120.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/profile3.jpg"),
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users_form_data")
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshots) {
                    var data = snapshots.data; // Get current user info
                    if (data == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // ------------------- show user info in the textfield--------------

                    nameController.text = data["name".toString()];
                    numberController.text = data["phone".toString()];

                    emailController.text = FirebaseAuth
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
                        CustomTextField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor.withValues(alpha: 0.6),
                          ),
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Container(
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
                                      color: AppColors.blackColor.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      "Username",
                                      style: Styles.smallTitle.copyWith(
                                        fontSize: 18.sp,
                                        color: AppColors.blackColor.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                showDialogueBox(
                                  context,
                                  "name",
                                  nameController, // 5
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
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor.withValues(alpha: 0.6),
                          ),
                          controller: numberController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Container(
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/call.png",
                                      fit: BoxFit.cover,
                                      height: 18.h,
                                      width: 18.w,
                                      color: AppColors.blackColor.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                    SizedBox(width: 14.w),
                                    Text(
                                      "Phone",
                                      style: Styles.smallTitle.copyWith(
                                        fontSize: 18.sp,
                                        color: AppColors.blackColor.withValues(
                                          alpha: 0.7,
                                        ),
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
                                  controller.text = numberController.text
                                      .toString();
                                  showDialogueBox(
                                    context,
                                    "number",
                                    numberController,
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
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor.withValues(alpha: 0.6),
                          ),
                          controller: emailController,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.email, size: 28),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Container(
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/email.png",
                                      fit: BoxFit.cover,
                                      height: 20.h,
                                      width: 20.w,
                                      color: AppColors.blackColor.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                    SizedBox(width: 14.w),
                                    Text(
                                      "Phone",
                                      style: Styles.smallTitle.copyWith(
                                        fontSize: 18.sp,
                                        color: AppColors.blackColor.withValues(
                                          alpha: 0.7,
                                        ),
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
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 120.h),
                CustomButton(onTap: () {}, text: "LOGOUT"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogueBox(
    BuildContext context,
    String userInfo, // name, phone
    TextEditingController controller, // int a
  ) {
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
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    updateData(userInfo, controller.text);
                  },
                  child: Text("Done", style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
