import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
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
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildHeader(),
                    SizedBox(height: 16.h),
                    _buildSearchBar(),
                    SizedBox(height: 20.h),
                    _buildTrendingSection(),
                    SizedBox(height: 10.h),
                    _buildPromoBanner(),
                    SizedBox(height: 10.h),
                    _buildBannerIndicators(),
                    SizedBox(height: 10.h),
                    _buildExploreSection(),
                    SizedBox(height: 10.h),
                    _buildAllProductsHeader(),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            _buildProductGrid(),
            SliverToBoxAdapter(
              child: SizedBox(height: 100.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GetBuilder<UserController>(
      builder: (controller) {

        final user = controller.userData;
        return Row(
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
            const Spacer(),
            _buildIconWithBadge(
              icon: Assets.icons.card.svg(),
              badgeCount: 1,
              onTap: () => Get.toNamed(AppRoutes.progressScreen),
            ),
            SizedBox(width: 16.w),
            _buildIconWithBadge(
              icon: Assets.icons.notification.svg(),
              badgeCount: 9,
              onTap: () => Get.toNamed(AppRoutes.notificationScreen),
            ),
          ],
        );
      }
    );
  }

  Widget _buildIconWithBadge({
    required Widget icon,
    required int badgeCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          icon,
          if (badgeCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                child: Text(
                  badgeCount > 9 ? '9+' : badgeCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Search by products name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
            ),
          ),
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "Trending now",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.allProductScreen),
          child: CustomText(
            text: "See all...",
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return SizedBox(
      height: 168.h,
      child: PageView.builder(
        controller: _bannerController,
        onPageChanged: (index) {
          setState(() {
            _currentBannerIndex = index;
          });
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.8),
                  AppColors.primaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20.w,
                  bottom: -20.h,
                  child: Container(
                    height: 120.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Boost your products !!!",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        child: CustomText(
                          text: "Boost your product visibility and sales with targeted strategies, enhancing reach and customer engagement effectively.",
                          fontSize: 11.sp,
                          color: Colors.black,
                          maxline: 3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.white, width: 1.5.r)
                        ),
                        child: CustomText(
                          text: "Boost now",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBannerIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: _currentBannerIndex == index ? 24.w : 8.w,
          decoration: BoxDecoration(
            color: _currentBannerIndex == index
                ? AppColors.primaryColor
                : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categoryList.map((category) {
            return _buildCategoryItem(
              title: category["title"],
              icon: category["icon"],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({required String title, required IconData icon}) {
    return Container(
      height: 106.h,
      width: 85.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Icon(
            icon,
            size: 32.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: title,
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildAllProductsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "All Products",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.allProductScreen),
          child: CustomText(
            text: "See all...",
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
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
