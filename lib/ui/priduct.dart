import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Product extends StatefulWidget {
  static final String path = "Product";
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var dotPosition = 0;
  List products = [];
  var firestoreInstance = FirebaseFirestore.instance;

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
    fatchProduts();
    super.initState();
  }

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
            "Products",
            style: Styles.bodyLarge.copyWith(
              color: AppColors.blackColor.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppDimansion.kDefaultPadding,
            child: Column(
              children: [
                products == null
                    ? CircularProgressIndicator()
                    : GridView.builder(
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                  builder: (context) => DetailsScreen(
                                    allProduct: products[index],
                                  ),
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
                                    Text(
                                      "\$${products[index]["product-price"]}",
                                    ),
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
      ),
    );
  }
}
