import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    if(_controller.listedProductsData.isEmpty){
      _controller.productsGet(type: 'own', status: 'available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Products History."),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.createProductScreen);
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 80.h),
          child: Container(
            height: 53.h,
            width: 53.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 24.r),
          ),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          return ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 40.h,
              indicatorColor: AppColors.primaryColor,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp, color: AppColors.dividerColor),
            ),
            tabs: [
              Text('Listed: ${controller.listedProductsData.length}'),
              Text('Pending: ${controller.pendingProductsData.length}'),
            ],
            views: [

              // ── Listed Tab ──
              controller.isLoadingProduct
                  ? ShimmerHelper.instance.showMyProductShimmer()
                  : controller.listedProductsData.isEmpty
                  ? Center(child: Text('No listed products found.'))
                  : AnimationLimiter(
                child: ListView.builder(
                  itemCount: controller.listedProductsData.length,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  itemBuilder: (context, index) {
                    final product = controller.listedProductsData[index];
                    return CustomMyProductCard(
                      index: index,
                      leftBtnName: "Buy now",
                      boast: "Boost now",
                      title: product.productName,
                      price: product.price,
                      image: product.image,
                      onTap: () => Get.toNamed(
                        AppRoutes.productDetailsScreen,
                        arguments: product,
                      ),
                      boostOnTap: () => Get.toNamed(
                        AppRoutes.boostScreen,
                        arguments: product,
                      ),
                    );
                  },
                ),
              ),

              // ── Pending Tab ──
              controller.isLoadingProduct
                  ? ShimmerHelper.instance.showMyProductShimmer()
                  : controller.pendingProductsData.isEmpty
                  ? Center(child: Text('No pending products found.'))
                  : AnimationLimiter(
                child: ListView.builder(
                  itemCount: controller.pendingProductsData.length,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  itemBuilder: (context, index) {
                    final product = controller.pendingProductsData[index];
                    return CustomMyProductCard(
                      index: index,
                      title: product.productName,
                      price: product.price,
                      image: product.image,
                      onTap: () => Get.toNamed(
                        AppRoutes.productDetailsScreen,
                        arguments: product,
                      ),
                    );
                  },
                ),
              ),
            ],
            onChange: (index) {
              if (index == 0) {
                if(controller.listedProductsData.isEmpty){
                  controller.productsGet(type: 'own', status: 'available');
                }
              } else if (index == 1) {
                if(controller.pendingProductsData.isEmpty){
                  controller.productsGet(type: 'own', status: 'pending');
                }
              }
            },
          );
        },
      ),
    );
  }
}


class CustomMyProductCard extends StatefulWidget {
  final int? index;
  final String? title;
  final String? price;
  final String? image;
  final String? progressStatus;
  final String? leftBtnName;
  final String? rightBtnName;
  final String? boast;
  final bool? isFavorite;
  final bool? isBookMarkNeed;
  final VoidCallback? onTap;
  final VoidCallback? boostOnTap;

  const CustomMyProductCard({
    super.key,
    this.index,
    this.title,
    this.price,
    this.image,
    this.isFavorite,
    this.onTap,
    this.leftBtnName,
    this.rightBtnName,
    this.isBookMarkNeed,
    this.progressStatus,
    this.boast,
    this.boostOnTap,
  });

  @override
  State<CustomMyProductCard> createState() => _CustomMyProductCardState();
}

class _CustomMyProductCardState extends State<CustomMyProductCard> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: widget.index ?? 0,
      columnCount: 2,
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50,
        child: SlideAnimation(
          delay: Duration(milliseconds: 275),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(6.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section
                    CustomNetworkImage(
                      borderRadius: BorderRadius.circular(8.r),
                      imageUrl: "${widget.image}",
                      height: 142.h,
                      width: 102.w,
                    ),
                    SizedBox(width: 7.w),

                    // Info Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  textAlign: TextAlign.start,
                                  text: "${widget.title}",
                                  fontWeight: FontWeight.w600,
                                  bottom: 4.h,
                                  color: Colors.black,
                                ),
                              ),
                              if (widget.isBookMarkNeed ?? false)
                                widget.isFavorite ?? false
                                    ? Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.delete_outline_sharp,
                                    color: Colors.white,
                                    size: 16.h,
                                  ),
                                )
                                    : SizedBox(),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: "Price: ${widget.price}\$",
                            fontWeight: FontWeight.w500,
                            bottom: 8.h,
                          ),
                          CustomText(
                            maxline: 3,
                            text: "Transform your look with expert cuts, styling, and personalized service at our premier salon, designed for your ultimate satisfaction.",
                            fontSize: 10.h,
                            textAlign: TextAlign.start,
                            bottom: 4.h,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10.h),
                          if (widget.boast != null)
                            CustomButton(
                              color: widget.boast == "Boost now"
                                  ? AppColors.primaryColor
                                  : Color(0xffEFF8F8),
                              boderColor: widget.boast == "Boost now"
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              titlecolor: widget.boast == "Boost now"
                                  ? Colors.white
                                  : AppColors.primaryColor,
                              height: 30.h,
                              fontSize: 12.h,
                              width: 140.w,
                              loaderIgnore: true,
                              title: "${widget.boast}",
                              onpress: widget.boostOnTap ?? () {},
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}