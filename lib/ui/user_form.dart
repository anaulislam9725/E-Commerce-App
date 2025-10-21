
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/user_form_controller.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserForm extends StatefulWidget {
  static final String path = "/UserForm";
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  @override
  Widget build(BuildContext context) {
    final UserFormController userFormController=Get.put(UserFormController());
    return Scaffold(
      body: Padding(
        padding: AppDimansions.kDefaultPadding,
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
                      controller: userFormController.nameController,

                      hintText: "enter your name",
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: userFormController. numberController,
                      hintText: "enter your phone number",
                    ),

                    SizedBox(height: 12.h),
                    CustomTextField(
                      contentPadding: EdgeInsets.only(left: 40),
                      readOnly: userFormController. readonly,
                      controller: userFormController.dateOfBirthController,
                      hintText: "dete of birth",
                      suffixIcon: IconButton(
                        onPressed: () {
                         userFormController. selectDateFormPicker(context);
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
                      readOnly: userFormController. readonly,
                      controller: userFormController.genterController,
                      hintText: "gender",
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconSize: 50,
                          iconDisabledColor: AppColors.whiteColor,
                          iconEnabledColor: AppColors.whiteColor,
                          items: userFormController.gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: () {
                                setState(() {
                                userFormController.  genterController.text = value;
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
                      controller: userFormController. ageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      hintText: "enter your age",
                    ),
                    SizedBox(height: 60.h),
                    CustomButton(
                      onTap: () {
                       userFormController. sendUserDataToDB(context);
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
