import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:danceattix/controllers/fvrt_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/views/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/custom_app_bar.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final FvrtProductController _fvrtProductController =
  Get.find<FvrtProductController>();

  // ScrollControllers for pagination
  final ScrollController _fvrtScrollController = ScrollController();
  final ScrollController _purchasesScrollController = ScrollController();
  final ScrollController _salesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_fvrtProductController.fvrtData.isEmpty) {
        _fvrtProductController.fvrtGet();
      }
    });

    // Pagination listeners
    _fvrtScrollController.addListener(() {
      if (_fvrtScrollController.position.pixels >=
          _fvrtScrollController.position.maxScrollExtent - 200) {
        _fvrtProductController.fvrtMore();
      }
    });

    _purchasesScrollController.addListener(() {
      if (_purchasesScrollController.position.pixels >=
          _purchasesScrollController.position.maxScrollExtent - 200) {
        _fvrtProductController.phurcasesMore();
      }
    });

    _salesScrollController.addListener(() {
      if (_salesScrollController.position.pixels >=
          _salesScrollController.position.maxScrollExtent - 200) {
        _fvrtProductController.salesMore();
      }
    });
  }

  @override
  void dispose() {
    _fvrtScrollController.dispose();
    _purchasesScrollController.dispose();
    _salesScrollController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    switch (index) {
      case 0:
        if (_fvrtProductController.fvrtData.isEmpty) {
          _fvrtProductController.fvrtGet();
        }
        break;
      case 1:
        if (_fvrtProductController.purchasesData.isEmpty) {
          _fvrtProductController.phurcasesGet();
        }
        break;
      case 2:
        if (_fvrtProductController.salesData.isEmpty) {
          _fvrtProductController.salesGet();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Products History."),
      body: GetBuilder<FvrtProductController>(
        builder: (controller) {
          return ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 40.h,
              indicatorColor: AppColors.primaryColor,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle:
              TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp, color: AppColors.dividerColor),
            ),
            tabs: [
              Text('  Favorite  '),
              Text('  Purchased  '),
              Text('  History  '),
            ],
            views: [
              // ── Favorite Tab ──
              controller.isLoading
                  ? ShimmerHelper.instance.showMyProductShimmer()
                  : controller.fvrtData.isEmpty
                  ? const Center(child: Text('No favourite products found.'))
                  : AnimationLimiter(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fvrtGet();
                  },
                  child: ListView.builder(
                    controller: _fvrtScrollController,
                    itemCount: controller.fvrtData.length +
                        (controller.isLoadingMore ? 1 : 0),
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h, horizontal: 16.w),
                    itemBuilder: (context, index) {
                      if (index == controller.fvrtData.length) {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            ));
                      }
                      final product = controller.fvrtData[index];
                      return CustomProductCard(
                        index: index,
                        leftBtnName: "Buy now",
                        rightBtnName: "Message",
                        isBookMarkNeed: true,
                        isFavorite: true,
                        title: product.productName,
                        price: product.price,
                        image: product.images?.first.image ?? 'N/A',
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.productDetailsScreen,
                            arguments: product.id,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              // ── Purchased Tab ──
              controller.isPurchasesLoading
                  ? ShimmerHelper.instance.showMyProductShimmer()
                  : controller.purchasesData.isEmpty
                  ? const Center(
                  child: Text('No purchased products found.'))
                  : AnimationLimiter(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.phurcasesGet();
                  },
                  child: ListView.builder(
                    controller: _purchasesScrollController,
                    itemCount: controller.purchasesData.length +
                        (controller.isPurchasesLoadingMore ? 1 : 0),
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h, horizontal: 16.w),
                    itemBuilder: (context, index) {
                      if (index == controller.purchasesData.length) {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            ));
                      }
                      final product = controller.purchasesData[index];
                      return CustomProductCard(
                        index: index,
                        isBookMarkNeed: true,
                        isFavorite: false,
                        progressStatus: product.status,
                        title: product.productName,
                        price: product.price,
                        image: product.images?.first.image ?? 'N/A',
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.productDetailsScreen,
                            arguments: product.id,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              // ── History (Sales) Tab ──
              controller.isSalesLoading
                  ? ShimmerHelper.instance.showMyProductShimmer()
                  : controller.salesData.isEmpty
                  ? const Center(child: Text('No sales history found.'))
                  : AnimationLimiter(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.salesGet();
                  },
                  child: ListView.builder(
                    controller: _salesScrollController,
                    itemCount: controller.salesData.length +
                        (controller.isSalesLoadingMore ? 1 : 0),
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h, horizontal: 16.w),
                    itemBuilder: (context, index) {
                      if (index == controller.salesData.length) {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(),
                            ));
                      }
                      final product = controller.salesData[index];
                      return CustomProductCard(
                        index: index,
                        isBookMarkNeed: true,
                        isFavorite: false,
                        isHistory: true,
                        progressStatus: product.status,
                        title: product.productName,
                        price: product.price,
                        image: product.images?.first.image ?? 'N/A',
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.productDetailsScreen,
                            arguments: product.id,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
            onChange: (index) => _onTabChanged(index),
          );
        },
      ),
    );
  }
}