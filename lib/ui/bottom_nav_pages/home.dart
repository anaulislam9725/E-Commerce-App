import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/priduct.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:e_commerce_app/ui/search_screen.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  static final String path = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  List<String> carouselImages = [];
  var dotPosition = 0;
  List products = [];
  var name;
  // ignore: non_constant_identifier_names

  var firestoreInstance = FirebaseFirestore.instance;

  fatchCarouselImages() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("carusal-slider")
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselImages.add(qn.docs[i]["image"]);
        // ignore: avoid_print
      }
    });

    return qn.docs;
  }

  getUserName() async {
    var qn = await firestoreInstance
        .collection("users_form_data")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    name = qn["name"];
    // return name = qn["name"];
  }

  fatchProduts() async {
    QuerySnapshot qn = await firestoreInstance.collection("product").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        products.add({
          "product-name": qn.docs[i]["name"],
          "product-descrioption": qn.docs[i]["product-descrioption"],
          "product-price": qn.docs[i]["price"],
          "product-image": qn.docs[i]["image"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    getUserName();
    fatchCarouselImages();
    fatchProduts();
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
                name == null
                    ? Text("")
                    : Text(
                        name.toString(),
                        style: Styles.mediumTitle.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: Styles.secondaryFontFamily,
                        ),
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
                    child: Image.asset("assets/profile.jpg", fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: AppDimansion.kDefaultPadding,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            CustomTextField(
              readOnly: true,
              onTap: () {
                Navigator.pushNamed(context, SearchScreen.path);
              },
              borderRadius: AppDimansion.kBorderRadius,
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

                      child: CarouselSlider(
                        carouselController: CarouselSliderController(),
                        items: carouselImages
                            .map(
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
                          aspectRatio: 32 / 15,
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
                    SizedBox(height: 20),
                    DotsIndicator(
                      dotsCount: carouselImages.isEmpty
                          ? 1
                          : carouselImages.length,
                      position: dotPosition.toDouble(),
                      decorator: DotsDecorator(
                        color: AppColors.mainColor.withValues(alpha: 0.5),
                        activeColor: AppColors.mainColor,
                        size: Size(12, 12),
                        activeSize: Size(12, 12),
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
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,

                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        childAspectRatio: 1 / 1,
                      ),
                      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(allProduct: products[index]),
                              ),
                            ),
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Image.network(
                                    products[index]["product-image"][1],
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "${products[index]["product-name"]}",
                                    style: Styles.extraSmall.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  Text("\$${products[index]["product-price"]}"),
                                ],
                              ),
                            ),
                          ),
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
