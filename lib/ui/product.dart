import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Product extends StatefulWidget {
  static final String path = "Product";
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    Get.put(ProductController()).fatchProduts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
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
            padding: AppDimansions.kDefaultPadding,
            child: GetBuilder<ProductController>(
              builder: (controller) {
                return Column(
                  children: [
                    // ignore: unnecessary_null_comparison
                    controller.products == null
                        ? CircularProgressIndicator()
                        : GridView.builder(
                            itemCount: controller.products.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1,
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
                                          imageUrl: productController
                                              .products[index]["product-image"][1],
                                          fit: BoxFit.fitHeight,
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          "${controller.products[index]["product-name"]}",
                                          style: Styles.extraSmall.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.blackColor,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "\$${controller.products[index]["product-price"]}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
