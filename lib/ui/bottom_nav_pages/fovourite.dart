import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/favourite_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  static final path = "/FavouriteScreen";
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final FavouriteController favouriteController = Get.put(
      FavouriteController(),
    );
    return Scaffold(
      backgroundColor: AppColors.greyColor.withValues(alpha: 0.1),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: AppDimansions.kDefaultPadding,
          child: Text(
            "Favourite",
            style: Styles.bodyMedium.copyWith(
              fontSize: 22.sp,
              color: AppColors.blackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-fovourite-items")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.data?.docs == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshots.hasError) {
              return Center(child: Text("Something is wrong"));
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot documentSnapshot = snapshots.data!.docs[index];

                return Padding(
                  padding: AppDimansions.kDefaultPadding,
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(top: 18.h),
                    height: 70.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withValues(alpha: 0.6),
                          spreadRadius: 3.r,
                          offset: Offset(0, 5),
                          blurRadius: 12.r,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.widgetColor,
                    ),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: documentSnapshot["image"][1],
                            fit: BoxFit.cover,

                            width: 90.w,
                          ),
                        ),
                        title: Text(
                          documentSnapshot["name"].toString(),
                          style: Styles.bodyMedium.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.blackColor.withValues(alpha: 0.8),
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: SizedBox(
                            width: 100.w,
                            child: Text(
                              "\$${documentSnapshot["price"]}",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are you sure you want to delete this product?",
                                      style: Styles.bodyMedium.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.greyColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: Styles.bodySmall.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),

                                          TextButton(
                                            onPressed: () {
                                              favouriteController
                                                  .deleteFavourite(
                                                    context,
                                                    documentSnapshot,
                                                  );
                                            },
                                            child: Text(
                                              "Delete",
                                              style: Styles.bodySmall.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13.sp,
                                                color: AppColors.redColor
                                                    .withValues(alpha: 0.7),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

                            child: Image.asset(
                              "assets/trash.png",
                              width: 25.w,
                              height: 25.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
