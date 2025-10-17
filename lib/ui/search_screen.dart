import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  static final String path = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  var inputText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppDimansion.kDefaultPadding,
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/left-arrow.png",
                      height: 28.h,
                      width: 28.w,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              CustomTextField(
                autofocus: true,
                controller: searchController,
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                  });
                },
                borderRadius: AppDimansion.kBorderRadius,
                hintText: "Search",
                style: TextStyle(
                  color: AppColors.blackColor.withValues(alpha: 0.7),
                ),
                hintColor: AppColors.blackColor.withValues(alpha: 0.5),
                fillColor: AppColors.mainColor.withValues(alpha: 0.2),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: AppColors.blackColor.withValues(alpha: 0.5),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("product")
                      .where("name", isEqualTo: inputText)
                      .snapshots(),
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshots,
                      ) {
                        if (snapshots.hasError) {
                          return Center(child: Text("Something went wrong"));
                        }
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("Loading"));
                        }
                        return ListView(
                          children: snapshots.data!.docs.map((
                            DocumentSnapshot document,
                          ) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: (){

                              },
                              child: Card(
                                elevation: 8,
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(left: 8),
                                  title: Text(data["name"]),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      data["image"][1],
                                      fit: BoxFit.cover,
                                      width: 90.w,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
