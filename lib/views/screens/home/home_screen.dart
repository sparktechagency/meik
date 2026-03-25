import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/views/screens/bottom_nav_bar/bottom_nav_controller.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:danceattix/views/widgets/custom_container.dart';
import 'package:danceattix/views/widgets/custom_text_field.dart';
import 'package:danceattix/views/widgets/search_popup_widget.dart';
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
              GlobalSearchField(
                hintText: 'Search by products name',
                primaryColor: AppColors.primaryColor,
                onSearch: (term) async {
                  await _productController.productsGet(term: term);
                  return _productController.searchResults
                      .map((e) => SearchItem(
                    id: e.id ?? 0,
                    name: e.productName ?? '',
                    image: e.image,
                    subtitle: e.price ?? '',
                  ))
                      .toList();
                },
                cardBuilder: (item, onTap) {
                  final product = item;
                  return ListTile(
                    onTap: (){
                      Get.toNamed(AppRoutes.productDetailsScreen,arguments: item.id);
                    },
                    leading: CustomNetworkImage(
                      borderRadius: BorderRadius.circular(10.r),
                      imageUrl: product.image ?? '',
                      height: 40.h,
                      width: 40.w,
                    ),
                    title: CustomText(
                      textAlign: TextAlign.start,
                        text:  product.name ?? ''),
                    subtitle: CustomText(
                        textAlign: TextAlign.start,
                        fontSize: 12.sp,
                        text:  'price: ${product.subtitle}'),
                  );
                },
              ),
              SizedBox(height: 10.h),
              CustomContainer(
                radiusAll: 20.r,
                horizontalMargin: 16.w,
                height: 164.h,
                width: double.infinity,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                clipBehavior: Clip.hardEdge,
                linearColors: [
                  Color(0xffCCE8E8),
                  AppColors.primaryColor,
                ],
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      bottom: -95,
                      right: -75,
                      child: CustomContainer(
                        color: Color(0xffCCE8E8),
                        shape: BoxShape.circle,
                        height: 218.r,
                        width: 218.r,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 18.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text:
                              'Boost your products !!!',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 8.h),
                            CustomText(text:
                              'Boost your product visibility and sales with targeted\nstrategies, enhancing reach and customer engagement\neffectively.',
                                fontSize: 10.sp,
                              color: Color(0xff545454),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 14.h),
                            CustomContainer(
                              onTap: (){
                                Get.find<BottomNavController>().onChange(3);
                              },
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                )
                              ],
                              borderWidth: 0.5,
                              bordersColor: Colors.white,
                              radiusAll: 100.r,
                              color: AppColors.primaryColor,
                              paddingHorizontal: 26.w,
                              paddingVertical: 7.h,
                              child: CustomText(text:
                                'Boost now',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                        childAspectRatio: 170.w / 245.h,
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
                      enableAutoTranslate: false,
                      text: '${user.fullName ?? 'N/A'} !',
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      enableAutoTranslate: false,
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
        // GestureDetector(
        //   onTap: () => Get.toNamed(AppRoutes.progressScreen),
        //   child: badges.Badge(
        //     badgeStyle: badges.BadgeStyle(
        //       padding: EdgeInsets.all(3.r),
        //       elevation: 0,
        //     ),
        //     position: badges.BadgePosition.topEnd(top: -4, end: -4),
        //     showBadge: true,
        //     ignorePointer: false,
        //     badgeContent: CustomText(
        //       text: '0',
        //       color: Colors.white,
        //       fontSize: 8.sp,
        //       fontWeight: FontWeight.w300,
        //     ),
        //     child: Assets.icons.card.svg(),
        //   ),
        // ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontSize: 16.sp),
          if (onSeeAllTap != null)
            GestureDetector(
              onTap: onSeeAllTap,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                  onPressed: onSeeAllTap, child: CustomText(text: 'See all', fontSize: 14.sp)),
            ),
        ],
      ),
    );
  }
}
