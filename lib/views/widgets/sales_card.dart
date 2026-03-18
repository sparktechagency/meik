import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/app_constants/app_colors.dart';
import 'cachanetwork_image.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class SalesCard extends StatelessWidget {
  final int? index;
  final String? productName;
  final String? productImage;
  final String? buyerName;
  final String? price;
  final String? total;
  final String? status;
  final String? paymentStatus;
  final String? condition;
  final String? brand;
  final String? deliveryCity;
  final String? deliveryAddress;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptTap;

  const SalesCard({
    super.key,
    this.index,
    this.productName,
    this.productImage,
    this.buyerName,
    this.price,
    this.total,
    this.status,
    this.paymentStatus,
    this.condition,
    this.brand,
    this.deliveryCity,
    this.deliveryAddress,
    this.onTap,
    this.onAcceptTap,
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

                        // Buyer Name Badge
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
                            text: 'Buyer: ${buyerName ?? 'Unknown'}',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        SizedBox(height: 14.h),

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
                            // Payment Status Badge
                            if (paymentStatus != null &&
                                paymentStatus!.isNotEmpty) ...[
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: paymentStatus?.toLowerCase() == 'completed'
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.orange.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: CustomText(
                                  text:
                                  'Payment: ${paymentStatus ?? 'pending'}',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: paymentStatus?.toLowerCase() == 'completed'
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ],
                        ),


                        // // Confirm Sale Button
                        // if (status?.toLowerCase() == 'pending' &&
                        //     paymentStatus?.toLowerCase() ==
                        //         'completed') ...[
                        //   SizedBox(height: 10.h),
                        //   SizedBox(
                        //     width: double.infinity,
                        //     height: 36.h,
                        //     child: CustomButton(
                        //       title: 'Confirm Sale',
                        //       onpress: onAcceptTap ?? () {},
                        //     ),
                        //   ),
                        //],
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