import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class BoostScreen extends StatelessWidget {
  const BoostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Boost"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            // Basic Plan
            _buildPlanCard(
              planName: "Basic",
              price: "\$ 3.00",
              duration: "1 week",
              features: [
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
              ],
              onPurchase: () {
                // Handle Basic plan purchase
              },
            ),
            SizedBox(height: 16.h),

            // Standard Plan
            _buildPlanCard(
              planName: "Standard",
              price: "\$ 5.00",
              duration: "2 week",
              features: [
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
              ],
              onPurchase: () {
                // Handle Standard plan purchase
              },
            ),
            SizedBox(height: 16.h),

            // Premium Plan
            _buildPlanCard(
              planName: "Premium",
              price: "\$ 8.90",
              duration: "1 Month",
              features: [
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
                "Add quote",
              ],
              onPurchase: () {
                // Handle Premium plan purchase
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String planName,
    required String price,
    required String duration,
    required List<String> features,
    required VoidCallback onPurchase,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan Name
          CustomText(
            text: planName,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff8B1538),
          ),
          SizedBox(height: 8.h),

          // Price and Duration
          Row(
            children: [
              CustomText(
                text: price,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              CustomText(
                text: "/ $duration",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Features List
          ...features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: feature,
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ],
                ),
              )),
          SizedBox(height: 8.h),

          // Purchase Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
              child: CustomText(
                text: "Purchase now.",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
