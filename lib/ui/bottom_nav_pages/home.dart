import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/home_controller.dart';
import 'package:e_commerce_app/ui/product.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:e_commerce_app/ui/search_screen.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static final String path = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getUserName();
    homeController.fatchCarouselImages();
    homeController.fatchProduts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: SizedBox(
          height: 120.h,
          child: Padding(
            padding: EdgeInsets.only(top: 25.h, left: 24.w, right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "HI,",
                  style: Styles.mediumTitle.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GetBuilder<HomeController>(
                  builder: (controller) {
                    return homeController.name == null
                        ? Text("")
                        : Text(
                            homeController.name.toString(),
                            style: Styles.mediumTitle.copyWith(
                              color: AppColors.blackColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: Styles.secondaryFontFamily,
                            ),
                          );
                  },
                ),
                Spacer(),

                Container(
                  height: 64.h,
                  width: 64.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyColor,
                        spreadRadius: 2,
                        offset: Offset(4, 12),
                        blurRadius: 18,
                      ),
                    ],
                    shape: BoxShape.circle,

                    border: Border.all(width: 2.w, color: Colors.grey),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/profile3.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: AppDimansions.kDefaultPadding,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            CustomTextField(
              readOnly: true,
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.path);
              },
              borderRadius: AppDimansions.kBorderRadius,
              hintText: "Search",
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
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),

                      child: GetBuilder<HomeController>(
                        builder: (controller) {
                          return CarouselSlider(
                            carouselController: CarouselSliderController(),
                            items: homeController.carouselImages
                                .map(
                                  (item) => ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      imageUrl: item,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              aspectRatio: 32 / 15,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              // ignore: non_constant_identifier_names
                              onPageChanged: (val, CarouselPageChangedReason) {
                                homeController.position(
                                  val,
                                  CarouselPageChangedReason,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20),
                    Obx(
                      () => DotsIndicator(
                        dotsCount: homeController.carouselImages.isEmpty
                            ? 1
                            : homeController.carouselImages.length,
                        position: homeController.dotPosition.value.toDouble(),
                        decorator: DotsDecorator(
                          color: AppColors.mainColor.withValues(alpha: 0.5),
                          activeColor: AppColors.mainColor,
                          size: Size(12, 12),
                          activeSize: Size(12, 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: Styles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Product.path);
                              },
                              child: Text(
                                "SHOP MORE",
                                style: Styles.bodyMedium.copyWith(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15.h,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,

                                childAspectRatio: 1 / 1.1,
                              ),
                          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 4,
                                bottom: 4,
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      allProduct: controller.products[index],
                                    ),
                                  ),
                                ),
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: controller
                                            .products[index]["product-image"][1],
                                        fit: BoxFit.fitHeight,
                                      ),
                                      SizedBox(height: 6.h),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5.w,
                                          right: 5.w,
                                        ),
                                        child: Text(
                                          "${controller.products[index]["product-name"]}",
                                          style: Styles.extraSmall.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.blackColor,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${controller.products[index]["product-price"]}",
                                        style: Styles.bodySmall.copyWith(
                                          color: AppColors.blackColor,
                                          // fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
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
