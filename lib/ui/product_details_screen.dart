import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/product_detail_controller.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/payment_successful_screen.dart';
import 'package:e_commerce_app/ui/search_screen.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  static final String path = "/DetailsScreen";
  final dynamic allProduct;
  const DetailsScreen({super.key, this.allProduct});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductDetailController productDetailController = Get.put(
      ProductDetailController(),
    );
    return Scaffold(
      backgroundColor: AppColors.widgetColor,
      appBar: AppBar(
        backgroundColor: AppColors.widgetColor,
        leadingWidth: 100,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: Image.asset(
            "assets/left-arrow.png",
            fit: BoxFit.cover,
            width: 34,
            color: AppColors.blackColor.withValues(alpha: 0.4),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Text(
            "Product Details",
            style: Styles.bodyLarge.copyWith(
              color: AppColors.blackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchScreen.path);
            },
            child: Icon(
              Icons.search,
              size: 26.h,
              color: AppColors.blackColor.withValues(alpha: 0.4),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 24.w, left: 12.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(isHide: true),
                  ),
                );
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 26.h,
                color: AppColors.blackColor.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: AppDimansions.kDefaultPadding,
                child: CarouselSlider(
                  carouselController: CarouselSliderController(),
                  items: widget.allProduct["product-image"]
                      .map<Widget>(
                        (item) => ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: CachedNetworkImage(
                            height: double.infinity.h,
                            width: double.infinity.w,
                            imageUrl: item,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    aspectRatio: 32 / 18,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,

                    onPageChanged: (val, carouselPageChanged) {
                      productDetailController.position(
                        val,
                        carouselPageChanged,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => DotsIndicator(
                  dotsCount:
                      (widget.allProduct["product-image"] as List).length,
                  position: productDetailController.dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.mainColor.withValues(alpha: 0.5),
                    activeColor: AppColors.mainColor,
                    size: Size(12, 12),
                    activeSize: Size(12, 12),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: AppDimansions.kDefaultPadding,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              widget.allProduct["product-name"],
                              style: Styles.smallTitle.copyWith(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 32.w, right: 32.w),
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                "\$${widget.allProduct["product-price"]}",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        widget.allProduct["product-descrioption"].toString(),
                        style: Styles.extraSmall.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 180,
        color: AppColors.whiteColor,
        child: Padding(
          padding: AppDimansions.kDefaultPadding,
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 6.w,
                      right: 6.w,
                      top: 3.h,
                      bottom: 3.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: BoxBorder.all(
                        color: AppColors.greyColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                if (productDetailController.currentValue > 1) {
                                  // ignore: void_checks
                                  return productDetailController.decrement();
                                }
                              },
                              child: Container(
                                height: 32.h,
                                width: 32.h,
                                decoration: BoxDecoration(
                                  color:
                                      productDetailController.currentValue == 1
                                      ? AppColors.greyColor.withValues(
                                          alpha: 0.2,
                                        )
                                      : AppColors.redColor.withValues(
                                          alpha: 0.1,
                                        ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color:
                                        productDetailController.currentValue ==
                                            1
                                        ? AppColors.greyColor
                                        : AppColors.redColor.withValues(
                                            alpha: 0.7,
                                          ),
                                    size: 24.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 8.w),
                              child: productDetailController.currentValue < 10
                                  ? Text(
                                      "0${productDetailController.currentValue}",
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      "${productDetailController.currentValue}",
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              productDetailController.increament();
                            },
                            child: Container(
                              height: 32.h,
                              width: 32.h,
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.150),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 24.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users-fovourite-items")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .where(
                          "name",
                          isEqualTo: widget.allProduct["product-name"],
                        )
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshots) {
                      if (snapshots.data == null) {
                        return Text("");
                      }
                      return Container(
                        height: 38.h,
                        width: 38.h,
                        decoration: BoxDecoration(
                          color: AppColors.redColor.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              snapshots.data.docs.length == 0
                                  ? productDetailController.addToFavourite(
                                      widget,
                                    )
                                  : Fluttertoast.showToast(
                                      msg: "Already added",
                                      toastLength: Toast.LENGTH_SHORT,

                                      backgroundColor: AppColors.greyColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                            },
                            icon: snapshots.data.docs.length == 0
                                ? Icon(
                                    Icons.favorite_outline,
                                    size: 20.h,
                                    color: AppColors.widgetColor,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    size: 20.h,
                                    color: AppColors.widgetColor,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users-cart-items")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .where(
                          "name",
                          isEqualTo: widget.allProduct["product-name"],
                        )
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshots) {
                      if (snapshots.data == null) {
                        return Text("");
                      }
                      return Container(
                        height: 42.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              snapshots.data.docs.length == 0
                                  ? productDetailController.addToCart(widget)
                                  : Fluttertoast.showToast(
                                      msg: "Already added",
                                      toastLength: Toast.LENGTH_SHORT,

                                      backgroundColor: AppColors.greyColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                            },
                            icon: snapshots.data.docs.length == 0
                                ? Padding(
                                    padding: EdgeInsets.only(right: 1.w),
                                    child: Image.asset(
                                      "assets/shopping.png",
                                      color: AppColors.widgetColor,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(right: 1.w),
                                    child: Image.asset(
                                      "assets/shoppingCart.png",
                                      color: AppColors.widgetColor,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  CustomButton(
                    borderRadius: BorderRadius.circular(12.r),
                    height: 42.h,
                    width: 260.w,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PaymentSuccessfulScreen.path,
                      );
                    },
                    text: "BOY NOW",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
