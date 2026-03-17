import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:danceattix/views/widgets/custom_container.dart';
import 'package:danceattix/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_home_product_card.dart';
import '../../widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  final ProductController _productController = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(_productController.productsData.isEmpty){
        _productController.productsGet();

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: _customAppBar(),
      body: RefreshIndicator(
        onRefresh: ()async{
          await  _productController.productsGet();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  hintextSize: 16.sp,
                  borderRadio: 50.r,
                 contentPaddingVertical: 0,
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
              SizedBox(height: 10.h),

              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.boostScreen),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Assets.images.boostBanner.image(
                    // height: 120.h,
                    // width: double.infinity,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              _buildSectionTitle(
                title: 'All Products',
                onSeeAllTap: () => Get.toNamed(AppRoutes.allProductScreen),
              ),

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
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 170.w / 234.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 0.h,
                      ),
                      itemCount: controller.productsData.length,
                      itemBuilder: (context, index) {
                        final product = controller.productsData[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: CustomProductCard(
                                isFavorite: true,
                                productID: product.id ?? 0,
                                title: product.productName ?? 'N/A',
                                description: product.description ?? 'N/A',
                                price: product.price.toString() ?? '',
                                rating: product.rating?.toDouble() ?? 0.0,
                                reviews: product.reviewCount.toString() ?? '0',
                                image: product.image,
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

              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _customAppBar() {
    return CustomAppBar(
      titleWidget: GetBuilder<UserController>(
        builder: (controller) {
          final user = controller.userData;
          if (user == null) {
            return const SizedBox();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profileScreen),
                  child: CustomNetworkImage(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    imageUrl: user.profileImage ?? '',
                    height: 48.h,
                    width: 48.w,
                    boxShape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: '${user.fullName ?? 'N/A'} !',
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "welcome to bazario",
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.progressScreen),
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              padding: EdgeInsets.all(3.r),
              elevation: 0,
            ),
            position: badges.BadgePosition.topEnd(top: -4, end: -4),
            showBadge: true,
            ignorePointer: false,
            badgeContent: CustomText(
              text: '0',
              color: Colors.white,
              fontSize: 8.sp,
              fontWeight: FontWeight.w300,
            ),
            child: Assets.icons.card.svg(),
          ),
        ),
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.notificationScreen),
          icon: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              padding: EdgeInsets.all(3.r),
              elevation: 0,
            ),
            position: badges.BadgePosition.topEnd(top: -6, end: -5),
            showBadge: true,
            ignorePointer: false,
            badgeContent: CustomText(
              text: '0',
              color: Colors.white,
              fontSize: 8.sp,
              fontWeight: FontWeight.w300,
            ),
            child: Assets.icons.notification.svg(),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({
    required String title,
    VoidCallback? onSeeAllTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontSize: 16.sp),
          if (onSeeAllTap != null)
            GestureDetector(
              onTap: onSeeAllTap,
              child: CustomText(text: "See all", fontSize: 10.sp),
            ),
        ],
      ),
    );
  }
}
