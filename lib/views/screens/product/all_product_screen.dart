import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/views/screens/drawer/drawer_screen.dart';
import 'package:danceattix/views/widgets/search_popup_widget.dart';
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
    super.initState();
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productController.productsGet();
    });
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
        onRefresh: () => _productController.productsGet(),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            //parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              GlobalSearchField(
                primaryColor: AppColors.primaryColor,
                onSearch: (term) async {
                  await _productController.productsGet(term: term);
                  return _productController.searchResults
                      .map(
                        (e) => SearchItem(
                      id: e.id ?? 0,
                      name: e.productName ?? '',
                      image: e.image,
                      subtitle: e.price ?? '',
                    ),
                  )
                      .toList();
                },
                cardBuilder: (item, onTap) {
                  return ListTile(
                    onTap: onTap,
                    leading: CustomNetworkImage(
                      borderRadius: BorderRadius.circular(10.r),
                      imageUrl: item.image ?? '',
                      height: 40.h,
                      width: 40.w,
                    ),
                    title: CustomText(
                      textAlign: TextAlign.start,
                      text: item.name,
                    ),
                    subtitle: CustomText(
                      textAlign: TextAlign.start,
                      fontSize: 12.sp,
                      text: 'price: ${item.subtitle}',
                    ),
                  );
                },
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
                    }

                    if (controller.productsData.isEmpty) {
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
                            CustomButton(
                              fontSize: 14.sp,
                              height: 34.h,
                              width: 100.w,
                              title: 'Refresh',
                              onpress: () => controller.productsGet(),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 170.w / 245.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 0.h,
                      ),
                      itemCount: controller.productsData.length +
                          (controller.isLoadingProductMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.productsData.length) {
                          return Padding(
                            padding: EdgeInsets.all(16.r),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
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
                                price: product.price.toString(),
                                rating: product.rating?.toDouble() ?? 0.0,
                                reviews: product.reviewCount.toString(),
                                image: product.image,
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
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _productController.productsMore('');
      }
    });
  }
}