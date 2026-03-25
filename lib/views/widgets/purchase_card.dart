import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/app_constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'cachanetwork_image.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class PurchaseCard extends StatelessWidget {
  final int? index;
  final String? productName;
  final String? productImage;
  final String? sellerName;
  final String? total;
  final String? status;
  final String? paymentStatus;
  final String? condition;
  final String? brand;
  final VoidCallback? onTap;
  final VoidCallback? onCompleted;

  const PurchaseCard({
    super.key,
    this.index,
    this.productName,
    this.productImage,
    this.sellerName,
    this.total,
    this.status,
    this.paymentStatus,
    this.condition,
    this.brand,
    this.onTap,
    this.onCompleted,
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
            height: 216.h,
           // height: 156.h,
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CustomNetworkImage(
                      imageUrl: productImage ?? '',
                      height: double.infinity,
                      width: 95.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        CustomText(
                          textAlign: TextAlign.start,
                          text: productName ?? 'N/A',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          maxline: 2,
                          color: Colors.black,
                        ),
                        SizedBox(height: 6.h),

                        // Brand
                        CustomText(
                          textAlign: TextAlign.start,
                          text: 'Brand: ${brand ?? 'N/A'}',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                          maxline: 1,
                        ),
                        SizedBox(height: 4.h),

                        // Condition
                        CustomText(
                          textAlign: TextAlign.start,
                          text: 'Condition: ${condition ?? 'N/A'}',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                        SizedBox(height: 6.h),

                        // Seller Name Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: 'Seller: ${sellerName ?? 'Unknown'}',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Price and Status Row
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: 'Price: \$${total ?? '0.00'}',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(status).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: CustomText(
                                text: status ?? 'pending',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(status),
                              ),
                            ),
                          ],
                        ),

                       // Received Button (only show if pending and payment completed)
                        if (status?.toLowerCase() == 'pending' &&
                            paymentStatus?.toLowerCase() == 'completed') ...[
                          SizedBox(height: 20.h),
                          SizedBox(
                            width: double.infinity,
                            height: 36.h,
                            child: CustomButton(
                              title: 'Mark as Received',
                              onpress: onCompleted ?? () {},
                            ),
                          ),
                        ],
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

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.amber;
      case 'received':
        return Colors.green;
      case 'cancel':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}