import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.widgetColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: AppDimansion.kDefaultPadding,
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: Image.asset(
                        "assets/left-arrow.png",
                        fit: BoxFit.cover,
                        width: 32.w,
                        color: AppColors.blackColor.withValues(alpha: 0.4),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Product Details",
                      style: Styles.bodyLarge.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      size: 26.h,
                      color: AppColors.blackColor.withValues(alpha: 0.4),
                    ),
                    Spacer(),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 26.h,
                      color: AppColors.blackColor.withValues(alpha: 0.4),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: AppDimansion.kDefaultPadding,
              child: CarouselSlider(
                carouselController: CarouselSliderController(),
                items: widget.allProduct["product-image"]
                    .map<Widget>(
                      (item) => Container(
                        decoration: BoxDecoration(
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
                  aspectRatio: 32 / 18,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  // enlargeStrategy: CenterPageEnlargeStrategy.scale,
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: AppDimansion.kDefaultPadding,
                  child: SingleChildScrollView(
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
                              height: 46,
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
                          // overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Container(
                              height: 42.h,
                              width: 42.h,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove, size: 28.h),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 8.w),
                              child: Text(
                                "01",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              height: 42.h,
                              width: 42.h,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add, size: 28.h),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
