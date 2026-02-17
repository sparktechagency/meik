import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/app_constants/app_colors.dart';
import '../../core/config/app_route.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'cachanetwork_image.dart';
import 'custom_text.dart';

class CustomHomeProductCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? price;
  final String? oldPrice;
  final String? image;
  final String? reviews;
  final double? rating;
  final bool? isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onBuyNowTap;
  final VoidCallback? onOfferTap;
  final VoidCallback? onMessageTap;

  const CustomHomeProductCard({
    super.key,
    this.title,
    this.description,
    this.price,
    this.oldPrice,
    this.image,
    this.reviews,
    this.rating,
    this.isFavorite,
    this.onTap,
    this.onFavoriteTap,
    this.onBuyNowTap,
    this.onOfferTap,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.toNamed(AppRoutes.productDetailsScreen),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Favorite Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: CustomNetworkImage(
                    imageUrl: image ?? "",
                    height: 124.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite == true ? Icons.favorite : Icons.favorite_border,
                        size: 18.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product Info
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomText(
                    text: title ?? "Product Name",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    maxline: 1,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 4.h),
                  // Description
                  CustomText(
                    text: description ?? "Product description goes here",
                    fontSize: 10.sp,
                    color: Colors.grey,
                    maxline: 2,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 6.h),
                  // Price Row
                  Row(
                    children: [
                      CustomText(
                        text: price ?? "\$0",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      if (oldPrice != null && oldPrice!.isNotEmpty) ...[
                        SizedBox(width: 8.w),
                        Text(
                          oldPrice!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Rating Row
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < (rating?.floor() ?? 0) ? Icons.star : Icons.star_border,
                          size: 14.sp,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: reviews ?? "(0)",
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Action Buttons Row
                  Row(
                    children: [
                      // Buy Now Button
                      Expanded(
                        child: GestureDetector(
                          onTap: onBuyNowTap,
                          child: Container(
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "Buy now",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      // Offer Button
                      Expanded(
                        child: GestureDetector(
                          onTap: onOfferTap,
                          child: Container(
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "Offer",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      // Message Icon
                      GestureDetector(
                        onTap: onMessageTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Assets.icons.message.svg(
                              colorFilter: const ColorFilter.mode(
                                Colors.black54,
                                BlendMode.srcIn,
                              ),
                              height: 10.h,
                              width: 10.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
