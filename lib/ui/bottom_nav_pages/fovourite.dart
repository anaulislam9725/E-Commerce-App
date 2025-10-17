import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavouriteScreen extends StatefulWidget {
  static final path = "/FavouriteScreen";
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // delete() {
  //   FirebaseFirestore.instance
  //       .collection("users-cart-items")
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection("items")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .delete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor.withValues(alpha: 0.1),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 5,
        leadingWidth: 60.w,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 26.w, right: 10.w),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, BottomNavController.path);
            },
            child: Image.asset(
              "assets/left-arrow.png",
              color: AppColors.blackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        title: Text(
          "Favourite",
          style: Styles.bodyMedium.copyWith(
            fontSize: 22.sp,
            color: AppColors.blackColor.withValues(alpha: 0.7),
          ),
        ),
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
                  padding: AppDimansion.kDefaultPadding,
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
                          child: Image.network(
                            documentSnapshot["image"][1],
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: 100.w,
                          ),
                        ),
                        title: Text(documentSnapshot["name"].toString()),
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
                            child: Icon(Icons.delete),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are you sure you want to delete this product?",
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
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),

                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                    "users-fovourite-items",
                                                  )
                                                  .doc(
                                                    FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .email,
                                                  )
                                                  .collection("items")
                                                  .doc(documentSnapshot.id)
                                                  .delete()
                                                  .then(
                                                    (onValue) {
                                                      Fluttertoast.showToast(
                                                        msg: "Deleted..",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,

                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            AppColors.greyColor,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pop(context);
                                                    },

                                                    // ignore: use_build_context_synchronously
                                                  );
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.red,
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

                            // child: Image.asset(
                            //   "assets/trash.png",
                            //   width: 25.w,
                            //   height: 25.h,
                            // ),
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
