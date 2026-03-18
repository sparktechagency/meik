import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:danceattix/controllers/boost_controller.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_controller.listedProductsData.isEmpty){
        _controller.productsGet(type: 'own', status: 'available');
      }
    });
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
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ProductController>(
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
                      child: RefreshIndicator(
                        onRefresh: ()async {
                          await  _controller.productsGet(type: 'own', status: 'available');
                        },
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
                                arguments: product.id,
                              ),
                              boostOnTap: () {
                                _showBoostPricingDialog(context, product.id ?? 0);
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // ── Pending Tab ──
                    controller.isLoadingProduct
                        ? ShimmerHelper.instance.showMyProductShimmer()
                        : controller.pendingProductsData.isEmpty
                        ? Center(child: Text('No pending products found.'))
                        : AnimationLimiter(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.productsGet(type: 'own', status: 'pending');
                        },
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
                                arguments: product.id,
                              ),
                            );
                          },
                        ),
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
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  /// Show boost pricing dialog with pricing list
  void _showBoostPricingDialog(BuildContext context, int productId) {
    final boostController = Get.find<BoostController>();

    // Fetch pricing data when dialog opens
    boostController.boostPricingGet(productID: productId.toString());

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              contentPadding: EdgeInsets.zero,
              content: GetBuilder<BoostController>(
                builder: (controller) {
                  // Get selected pricing from controller or use local state
                  int? selectedPricingIndex = controller.selectedPricingIndex;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.trending_up,
                                color: Colors.white,
                                size: 28.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Boost Your Post 🚀",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Choose a plan to increase visibility",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Loading State
                      if (controller.isLoadingPrices)
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Loading pricing options...",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        )
                      // Pricing List
                      else if (controller.boostPricingData.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12.h),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.boostPricingData.length,
                                itemBuilder: (context, index) {
                                  final pricing = controller.boostPricingData[index];
                                  final days = pricing.days ?? 0;
                                  final price = pricing.cost ?? 0;
                                  final currency = pricing.currency ?? 0;
                                  final isSelected = selectedPricingIndex == index;

                                  return GestureDetector(
                                    onTap: () {
                                      controller.setSelectedPricing(index);
                                    },
                                    child: _buildPricingCard(
                                      currency: currency,
                                      context: context,
                                      days: days,
                                      price: price,
                                      description: "Boost your post",
                                      isSelected: isSelected,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        )
                      // Empty State
                      else
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Icon(
                                Icons.info_outline,
                                color: Colors.grey.shade400,
                                size: 32.sp,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "No pricing options available",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),

                      SizedBox(height: 16.h),

                      // Action Buttons at Bottom
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                titlecolor: AppColors.primaryColor,
                                height: 42.h,
                                color: AppColors.primaryShade100,
                                borderRadius: 50.r,
                                onpress: () {
                                  Navigator.pop(context);
                                },
                                title: "Cancel",
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: GetBuilder<BoostController>(
                                builder: (boostCtrl) {
                                  return CustomButton(
                                    loading: boostCtrl.isLoading,
                                    height: 42.h,
                                    borderRadius: 50.r,
                                    onpress:  () {
                                      if (selectedPricingIndex == null) {
                                        showToast("Please select a pricing option.");
                                        return;}

                                      final selectedPricing =
                                      boostCtrl.boostPricingData[
                                      selectedPricingIndex];
                                      final days =
                                          selectedPricing.days ?? 0;
                                      boostCtrl.boost(productId, days);
                                    },
                                    title: "Boost Now",
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  /// Build individual pricing card
  Widget _buildPricingCard({
    required BuildContext context,
    required int days,
    required dynamic price,
    required dynamic currency,
    required String description,
    required bool isSelected,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.white,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Boost for $days Days",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$currency: $price",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
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