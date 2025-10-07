import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserForm extends StatefulWidget {
  static final String path = "/UserForm";
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genterController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final readonly = true;
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> selectDateFormPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        dateOfBirthController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
  }

  sendUserDataToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance.collection(
      "users_form_data",
    );
    return collectionRef
        .doc(currentUser!.email)
        .set({
          "name": nameController.text,
          "phone": numberController.text,
          "dob": dateOfBirthController.text,
          "gender": genterController.text,
          "age": ageController.text,
        })
        .then(
          (value) => Navigator.pushNamed(context, BottomNavController.path),
        );

    // ignore: avoid_print
    // .catchError((error) => print("something is wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDimansion.kDefaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80.h),
            Text(
              "Submit the form to continue.",
              style: Styles.smallTitle.copyWith(color: AppColors.mainColor),
            ),
            SizedBox(height: 6.h),
            Text(
              "We will not share your information with anyone",
              style: Styles.extraSmall,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    CustomTextField(
                      controller: nameController,

                      hintText: "enter your name",
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: numberController,
                      hintText: "enter your phone number",
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      contentPadding: EdgeInsets.only(left: 40),
                      readOnly: readonly,
                      controller: dateOfBirthController,
                      hintText: "dete of birth",
                      suffixIcon: IconButton(
                        onPressed: () {
                          selectDateFormPicker(context);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          size: 30,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      readOnly: readonly,
                      controller: genterController,
                      hintText: "gender",
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 50,
                          iconDisabledColor: AppColors.whiteColor,
                          iconEnabledColor: AppColors.whiteColor,
                          items: gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: () {
                                setState(() {
                                  genterController.text = value;
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      hintText: "enter your age",
                    ),
                    SizedBox(height: 60.h),
                    CustomButton(
                      onTap: () {
                        sendUserDataToDB();
                      },
                      text: "Continue",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
