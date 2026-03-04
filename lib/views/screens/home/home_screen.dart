import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
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
  final UserController _userController = Get.find<UserController>();
  final TextEditingController searchCtrl = TextEditingController();
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;

  final List<Map<String, dynamic>> categoryList = [
    {"title": "Clock", "icon": Icons.watch_later_outlined},
    {"title": "Cloth", "icon": Icons.checkroom_outlined},
    {"title": "Other", "icon": Icons.waves_outlined},
    {"title": "Other", "icon": Icons.grid_view_rounded},
  ];

  final List<Map<String, dynamic>> productList = [
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400"
    },
  ];

  @override
  void dispose() {
    searchCtrl.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: _customAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
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
                    padding:  EdgeInsets.symmetric(horizontal:  16.w),
                    child: Assets.images.boostBanner.image(
                      // height: 120.h,
                      // width: double.infinity,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                // _buildExploreSection(),
                _buildSectionTitle(title: 'Trending Products', onSeeAllTap: () => Get.toNamed(AppRoutes.allProductScreen)),


                SizedBox(
                  height: 273.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (context,index){
                    final product = productList[index % productList.length];
                    return CustomProductCard(
                      index: index,
                      title: product["title"],
                      description: product["description"],
                      price: product["price"],
                      oldPrice: product["oldPrice"],
                      rating: product["rating"],
                      reviews: product["reviews"],
                      image: product["image"],
                      isFavorite: false,
                      onFavoriteTap: () {},
                      onBuyNowTap: () {},
                      onOfferTap: () {},
                      onMessageTap: () {},
                    );
                  },),
                ),






                _buildSectionTitle(title: 'All Products', onSeeAllTap: () => Get.toNamed(AppRoutes.allProductScreen)),



                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 170.w / 263.h,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 0.h,
                  ),
                  itemCount: 12,
                  itemBuilder: (context,index){
                    final product = productList[index % productList.length];
                    return CustomProductCard(
                      title: product["title"],
                      description: product["description"],
                      price: product["price"],
                      oldPrice: product["oldPrice"],
                      rating: product["rating"],
                      reviews: product["reviews"],
                      image: product["image"],
                      isFavorite: false,
                      onFavoriteTap: () {},
                      onBuyNowTap: () {},
                      onOfferTap: () {},
                      onMessageTap: () {},
                    );
                  },),
              ],
            ),
           // _buildProductGrid(),
           //  SliverToBoxAdapter(
           //    child: SizedBox(height: 100.h),
           //  ),
        ),
      ),
    );
  }

  PreferredSizeWidget _customAppBar() {
    return CustomAppBar(
      titleWidget: GetBuilder<UserController>(
          builder: (controller) {

            final user = controller.userData;
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal:  16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profileScreen),
                    child: CustomNetworkImage(
                      border: Border.all(color: AppColors.primaryColor, width: 2),
                      imageUrl: user?.profileImage ?? '',
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
                        text: '${user?.fullName ?? 'N/A'} !',
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
          }
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
                text: '9+',
                color: Colors.white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w300,
              ),
              child: Assets.icons.card.svg(),
            )
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
                text: '9+',
                color: Colors.white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w300,
              ),
              child: Assets.icons.notification.svg(),
            )
        ),

      ],
    );
  }


  Widget _buildSectionTitle({required String title, VoidCallback? onSeeAllTap}) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 16.sp,
          ),
          if (onSeeAllTap != null)
          GestureDetector(
            onTap:  onSeeAllTap,
            child: CustomText(
              text: "See all",
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Explore Bazario",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          child: Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categoryList.map((category) {
              return _buildCategoryItem(
                title: category["title"],
                icon: category["icon"],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({required String title, required IconData icon}) {
    return CustomContainer(
      bordersColor: AppColors.primaryShade100,
      height: 106.h,
      width: 90.w,
        radiusAll: 8.r,
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],

      child: Column(
        children: [
          CustomContainer(
            width: double.infinity,
            radiusAll: 8.r,
            height: 70.h,
            marginAll: 4.r,
            color: Colors.white,
            child: Icon(
              icon,
              size: 32.sp,
              color: AppColors.primaryColor,
            ),
          ),
          CustomText(
            top: 2.h,
            text: title,
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }



  Widget _buildProductGrid() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 170.w / 263.h,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = productList[index % productList.length];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: CustomProductCard(
                    title: product["title"],
                    description: product["description"],
                    price: product["price"],
                    oldPrice: product["oldPrice"],
                    rating: product["rating"],
                    reviews: product["reviews"],
                    image: product["image"],
                    isFavorite: false,
                    onFavoriteTap: () {},
                    onBuyNowTap: () {},
                    onOfferTap: () {},
                    onMessageTap: () {},
                  ),
                ),
              ),
            );
          },
          childCount: productList.length,
        ),
      ),
    );
  }
}
