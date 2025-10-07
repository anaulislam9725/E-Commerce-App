import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
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
  TextEditingController SearchController = TextEditingController();
  var firestoreInstance = FirebaseFirestore.instance;

  fatchCarouselImages() async {
    QuerySnapshot qn = await firestoreInstance
        .collection("carusal-slider")
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselImages.add(qn.docs[i]["image"]);
        print(qn.docs[i]["image"]);
      }
    });

    return qn.docs;
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
    fatchCarouselImages();
    fatchProduts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDimansion.kDefaultPadding,
        child: Column(
          children: [
            SizedBox(height: 30.h),
            CustomTextField(
              controller: SearchController,
              hintText: "Search",
              hintColor: AppColors.blackColor,
              fillColor: AppColors.mainColor.withValues(alpha: 0.2),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: AppColors.blackColor),
              ),
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                carouselController: CarouselSliderController(),
                items: carouselImages
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
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
              dotsCount: carouselImages.length == 0 ? 1 : carouselImages.length,
              position: dotPosition.toDouble(),
              decorator: DotsDecorator(
                color: AppColors.mainColor.withValues(alpha: 0.5),
                activeColor: AppColors.mainColor,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: Styles.bodyMedium),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "SHOP MORE",
                        style: Styles.bodyMedium.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: AppColors.mainColor),
                  ],
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, Index) {
                  return Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Image.network(products[Index]["product-image"][0]),
                        Text("${products[Index]["product-name"]}"),
                        Text(products[Index]["product-price"].toString()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
