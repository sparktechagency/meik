import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:danceattix/controllers/fvrt_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/helper/shimmer_helper.dart';
import 'package:danceattix/views/widgets/fvrt_card.dart';
import 'package:danceattix/views/widgets/purchase_card.dart';
import 'package:danceattix/views/widgets/sales_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  // ════════════════════════════════════════════════════════════════════════════════
  // Helper function to get buyer/seller name
  // ════════════════════════════════════════════════════════════════════════════════
  String _buildPersonName(dynamic personData) {
    if (personData == null) return 'Unknown';

    // Access User class properties directly (NOT using bracket notation)
    try {
      final firstName = personData.firstName ?? '';
      final lastName = personData.lastName ?? '';
      final fullName = '$firstName $lastName'.trim();
      return fullName.isNotEmpty ? fullName : 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }

  // ════════════════════════════════════════════════════════════════════════════════
  // Show feedback dialog (for purchases when status is "received")
  // ════════════════════════════════════════════════════════════════════════════════
  void _showFeedbackDialog(BuildContext context, dynamic purchase) {
    TextEditingController commentController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Give Feedback",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              // Rating bar
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 28,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (value) {
                  rating = value;
                },
              ),
              SizedBox(height: 16.h),
              // Comments field
              TextField(
                controller: commentController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Share your experience...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit feedback
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feedback submitted successfully'),
                          ),
                        );
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Products History."),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<FvrtProductController>(
              builder: (controller) {
                return ContainedTabBarView(
                  tabBarProperties: TabBarProperties(
                    height: 40.h,
                    indicatorColor: AppColors.primaryColor,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.dividerColor,
                    ),
                  ),
                  tabs: [
                    Text('  Favorite  '),
                    Text('  Purchased  '),
                    Text('  History  '),
                  ],
                  views: [
                    // ════════════════════════════════════════════════════════════════════════════════
                    // ── FAVORITES TAB (using FavoritesCard) ──
                    // ════════════════════════════════════════════════════════════════════════════════
                    controller.isLoading
                        ? ShimmerHelper.instance.showMyProductShimmer()
                        : controller.fvrtData.isEmpty
                        ? const Center(
                            child: Text('No favourite products found.'),
                          )
                        : AnimationLimiter(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await controller.fvrtGet();
                              },
                              child: ListView.builder(
                                controller: _fvrtScrollController,
                                itemCount:
                                    controller.fvrtData.length +
                                    (controller.isLoadingMore ? 1 : 0),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 0.w,
                                ),
                                itemBuilder: (context, index) {
                                  // Loading indicator for pagination
                                  if (index == controller.fvrtData.length) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.r),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final product = controller.fvrtData[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: FavoritesCard(
                                        index: index,
                                        productName:
                                            product.productName ?? 'N/A',
                                        productImage:
                                            product.images?.isNotEmpty == true
                                            ? product.images!.first.image
                                            : null,
                                        sellerName: _buildPersonName(
                                          product.user,
                                        ),
                                        price: product.price ?? '0.00',
                                        condition: product.condition ?? 'N/A',
                                        brand: product.brand ?? 'N/A',
                                        isFavorite: true,
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.productDetailsScreen,
                                            arguments: product.id,
                                          );
                                        },
                                        onFavoriteTap: () {
                                          // Remove from favorites
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Removed from favorites',
                                              ),
                                            ),
                                          );
                                        },
                                        onAddToCartTap: () {
                                          // Add to cart
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Added to cart'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                    // ════════════════════════════════════════════════════════════════════════════════
                    // ── PURCHASES TAB (using PurchaseCard) ──
                    // ════════════════════════════════════════════════════════════════════════════════
                    controller.isPurchasesLoading
                        ? ShimmerHelper.instance.showMyProductShimmer()
                        : controller.purchasesData.isEmpty
                        ? const Center(
                            child: Text('No purchased products found.'),
                          )
                        : AnimationLimiter(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await controller.phurcasesGet();
                              },
                              child: ListView.builder(
                                controller: _purchasesScrollController,
                                itemCount:
                                    controller.purchasesData.length +
                                    (controller.isPurchasesLoadingMore ? 1 : 0),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 0.w,
                                ),
                                itemBuilder: (context, index) {
                                  // Loading indicator for pagination
                                  if (index ==
                                      controller.purchasesData.length) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.r),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final purchase =
                                      controller.purchasesData[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: PurchaseCard(
                                        index: index,
                                        productName:
                                            purchase.product?.productName ??
                                            'N/A',
                                        productImage:
                                            purchase
                                                    .product
                                                    ?.images
                                                    ?.isNotEmpty ==
                                                true
                                            ? purchase
                                                  .product!
                                                  .images!
                                                  .first
                                                  .image
                                            : null,
                                        sellerName: _buildPersonName(
                                          purchase.seller,
                                        ),
                                        total: purchase.total ?? '0.00',
                                        status:
                                            purchase.status
                                                ?.toString()
                                                .toLowerCase() ??
                                            'pending',
                                        paymentStatus:
                                            purchase.paymentStatus
                                                ?.toString()
                                                .toLowerCase() ??
                                            'pending',
                                        condition:
                                            purchase.product?.condition ??
                                            'N/A',
                                        brand: purchase.product?.brand ?? 'N/A',
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.productDetailsScreen,
                                            arguments: purchase.id,
                                          );
                                        },
                                        onCompleted: () {
                                          if (purchase.status?.toLowerCase() ==
                                              'received') {
                                            _showFeedbackDialog(
                                              context,
                                              purchase,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                    // ════════════════════════════════════════════════════════════════════════════════
                    // ── SALES/HISTORY TAB (using SalesCard) ──
                    // ════════════════════════════════════════════════════════════════════════════════
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
                                itemCount:
                                    controller.salesData.length +
                                    (controller.isSalesLoadingMore ? 1 : 0),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 0.w,
                                ),
                                itemBuilder: (context, index) {
                                  // Loading indicator for pagination
                                  if (index == controller.salesData.length) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.r),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final sale = controller.salesData[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: SalesCard(
                                        index: index,
                                        productName:
                                            sale.product?.productName ?? 'N/A',
                                        productImage:
                                            sale.product?.images?.isNotEmpty ==
                                                true
                                            ? sale.product!.images!.first.image
                                            : null,
                                        buyerName: _buildPersonName(sale.buyer),
                                        price:
                                            sale.product?.price?.toString() ??
                                            '0.00',
                                        total: sale.total ?? '0.00',
                                        status:
                                            sale.status
                                                ?.toString()
                                                .toLowerCase() ??
                                            'pending',
                                        paymentStatus:
                                            sale.paymentStatus
                                                ?.toString()
                                                .toLowerCase() ??
                                            'pending',
                                        condition:
                                            sale.product?.condition ?? 'N/A',
                                        brand: sale.product?.brand ?? 'N/A',
                                        deliveryAddress:
                                            sale.buyer?.address ??
                                            'Not provided',
                                        deliveryCity:
                                            sale.buyer?.address ??
                                            'Not provided',
                                        onTap: () {
                                          Get.toNamed(
                                            AppRoutes.productDetailsScreen,
                                            arguments: sale.id,
                                          );
                                        },
                                        onAcceptTap: () {
                                          // Confirm sale
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Sale confirmed!'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
