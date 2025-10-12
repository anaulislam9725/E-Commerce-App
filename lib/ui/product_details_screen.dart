import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  static final String path = "/DetailsScreen";
  final dynamic allProduct;
  const DetailsScreen({super.key, this.allProduct});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var dotPosition = 0;
  int currentValue = 1;

  @override
  Widget build(BuildContext context) {
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
            style: Styles.bodyLarge.copyWith(color: AppColors.greyColor),
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            size: 26.h,
            color: AppColors.blackColor.withValues(alpha: 0.4),
          ),

          Padding(
            padding: EdgeInsets.only(right: 24.w, left: 12.w),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 26.h,
              color: AppColors.blackColor.withValues(alpha: 0.4),
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
                padding: AppDimansion.kDefaultPadding,
                child: CarouselSlider(
                  carouselController: CarouselSliderController(),
                  items: widget.allProduct["product-image"]
                      .map<Widget>(
                        (item) => Container(
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.cover,
                            ),
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
                      setState(() {
                        dotPosition = val;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              DotsIndicator(
                dotsCount: (widget.allProduct["product-image"] as List).length,
                position: dotPosition.toDouble(),
                decorator: DotsDecorator(
                  color: AppColors.mainColor.withValues(alpha: 0.5),
                  activeColor: AppColors.mainColor,
                  size: Size(12, 12),
                  activeSize: Size(12, 12),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: AppDimansion.kDefaultPadding,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.allProduct["product-name"]
                                    .toString()
                                    .substring(0, 1)
                                    .toUpperCase() +
                                widget.allProduct["product-name"]
                                    .toString()
                                    .substring(
                                      1,
                                      widget.allProduct["product-name"]
                                          .toString()
                                          .length,
                                    ),

                            style: Styles.smallTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor.withValues(
                                alpha: 0.6,
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
          padding: AppDimansion.kDefaultPadding,
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
                          GestureDetector(
                            onTap: () {
                              if (currentValue > 1) {
                                return setState(() {
                                  currentValue--;
                                });
                              }
                            },
                            child: Container(
                              height: 32.h,
                              width: 32.h,
                              decoration: BoxDecoration(
                                color: currentValue == 1
                                    ? AppColors.greyColor.withValues(alpha: 0.2)
                                    : AppColors.redColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: currentValue == 1
                                      ? AppColors.greyColor
                                      : AppColors.redColor.withValues(
                                          alpha: 0.7,
                                        ),
                                  size: 24.h,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            child: currentValue < 10
                                ? Text(
                                    "0$currentValue",
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    "$currentValue",
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentValue++;
                              });
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
                  Container(
                    height: 38.h,
                    width: 38.h,
                    decoration: BoxDecoration(
                      color: AppColors.redColor.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: 20.h,
                          color: AppColors.widgetColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Container(
                    height: 42.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 28.h,
                          color: AppColors.widgetColor,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    borderRadius: BorderRadius.circular(12.r),
                    height: 42.h,
                    width: 260.w,
                    onTap: () {},
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
