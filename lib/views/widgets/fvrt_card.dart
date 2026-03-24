import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/app_constants/app_colors.dart';

class FavoritesCard extends StatelessWidget {
  final int? index;
  final String? productName;
  final String? productImage;
  final String? sellerName;
  final String? price;
  final String? condition;
  final String? brand;
  final bool? isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToCartTap;

  const FavoritesCard({
    super.key,
    this.index,
    this.productName,
    this.productImage,
    this.sellerName,
    this.price,
    this.condition,
    this.brand,
    this.isFavorite,
    this.onTap,
    this.onFavoriteTap,
    this.onAddToCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index ?? 0,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      height: double.infinity,
                      width: 95.w,
                      child: CustomNetworkImage(
                        imageUrl: productImage ?? '',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name with Favorite Button
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: productName ?? 'N/A',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                maxline: 1,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: onFavoriteTap,
                              child: Container(
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isFavorite ?? false
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.primaryColor,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),

                        // Brand
                        CustomText(
                          textAlign: TextAlign.start,
                          text: 'Brand: ${brand ?? 'N/A'}',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                          maxline: 1,
                        ),
                        SizedBox(height: 3.h),

                        // Condition
                        CustomText(
                          textAlign: TextAlign.start,
                          text: 'Condition: ${condition ?? 'N/A'}',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                          maxline: 1,
                        ),
                        SizedBox(height: 5.h),

                        // Seller Name Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: 'Seller: ${sellerName ?? 'Unknown'}',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            maxline: 1,
                          ),
                        ),
                        SizedBox(height: 6.h),

                        // Price and Add to Cart Row
                        CustomText(
                          textAlign: TextAlign.start,
                          text: '\$${price ?? '0.00'}',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
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
    );
  }
}