import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/views/screens/drawer/drawer_screen.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../widgets/custom_home_product_card.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final ProductController _productController = Get.find<ProductController>();

  @override
  void initState() {
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productController.productsGet();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgColor,
      endDrawer: DrawerScreen(),
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: Icon(Icons.tune, color: Colors.black, size: 24.sp),
          ),
        ],
        title: 'All Products',
      ),
      body: RefreshIndicator(
        elevation: 0,
        onRefresh: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _productController.productsGet();
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  hintextSize: 16.sp,
                  borderRadio: 50.r,
                  //contentPaddingVertical: 0,
                  borderColor: Colors.transparent,
                  validator: (_) => null,
                  hintText: 'Search by products name',
                  suffixIcon: CustomContainer(
                    marginAll: 2.r,
                    paddingAll: 8.r,
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    child: Icon(
                      Icons.search,
                      //size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  controller: searchCtrl,
                ),
              ),
              GetBuilder<ProductController>(
                builder: (controller) {
                  return CustomText(
                    left: 16.w,
                    right: 16.w,
                    top: 8.h,
                    text: "Products (${controller.totalProduct})",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  );
                },
              ),
              SizedBox(height: 12.h),

              AnimationLimiter(
                child: GetBuilder<ProductController>(
                  builder: (controller) {
                    if (controller.isLoadingProduct) {
                      return ShimmerHelper.instance.showProductShimmer();
                    } else if (controller.productsData.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.lottie.emptyData.lottie(),
                            CustomText(
                              text: 'No Data Found',
                              color: AppColors.hitTextColorA5A5A5,
                              fontSize: 16.sp,
                            ),
                            SizedBox(height: 16.h),

                            /// 🔄 Refresh Button
                            CustomButton(
                              fontSize: 14.sp,
                              height: 34.h,
                              width: 100.w,
                              title: 'Refresh',
                              onpress: () async {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  controller.productsGet();
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return GridView.builder(
                      controller: _scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 170.w / 258.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 0.h,
                      ),
                      itemCount:
                          controller.productsData.length +
                          (controller.isLoadingProductMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.productsData.length) {
                          return Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                        final product = controller.productsData[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: CustomProductCard(
                                productID: product.id ?? 0,
                                title: product.productName ?? 'N/A',
                                description: product.description ?? 'N/A',
                                price: product.price.toString() ?? '',
                                rating: product.rating?.toDouble() ?? 0.0,
                                reviews: product.reviewCount.toString() ?? '0',
                                image: product.image,
                                onFavoriteTap: () {},
                                onBuyNowTap: () {},
                                onOfferTap: () {},
                                onMessageTap: () {},
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _productController.productsGet();
        debugPrint("load more true");
      }
    });
  }
}
