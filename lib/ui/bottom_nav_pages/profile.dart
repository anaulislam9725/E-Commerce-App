import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  static final String path = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? numberController;
  TextEditingController? emailController;
  final controller = TextEditingController();
  setdataToTextfild(data) {
    return Column(
      children: [
        CustomTextField(
          readOnly: true,
          style: TextStyle(color: AppColors.greyColor),
          controller: nameController = TextEditingController(
            text: data["name".toString()],
          ),
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
                onPressed: () {
                  controller.text = nameController!.text;
                  showDialogueBox(context,"name" ,nameController!);
                },
                icon: Icon(Icons.edit, color: AppColors.greyColor, size: 26.h),
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
          readOnly: true,
          style: TextStyle(color: AppColors.greyColor),
          controller: numberController = TextEditingController(
            text: data["phone".toString()],
          ),
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
                onPressed: () {
                  controller.text = numberController!.text.toString();
                  showDialogueBox(context,"number", numberController!);
                },
                icon: Icon(Icons.edit, color: AppColors.greyColor, size: 26.h),
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
          style: TextStyle(color: AppColors.greyColor),
          controller: emailController = TextEditingController(
            text: FirebaseAuth.instance.currentUser!.email.toString(),
          ),
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.email, size: 28),
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
      ],
    );
  }

  updateData(String key,String value) {
    CollectionReference collectionData = FirebaseFirestore.instance.collection(
      "users_form_data",
    );
    return collectionData
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          key:value
          // "name": nameController?.text,
          // "phone": numberController?.text,
          // "email": emailController?.text,
        })
        .then((onValue) => print("updetet successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        leadingWidth: 110.w,
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
                    var data = snapshots.data;
                    print(data);
                    if (data == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return setdataToTextfild(data);
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

  showDialogueBox(BuildContext context,String userInfo, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit"),
          actions: [
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
                    updateData(userInfo ,controller.text);
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
