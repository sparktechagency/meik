import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhiteFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.bgColorWhiteFFFFFF,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Wallet",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Overview Title
            CustomText(
              text: "Overview",
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),

            SizedBox(height: 16.h),

            // Balance Card
            _buildBalanceCard(),

            SizedBox(height: 24.h),

            // History Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "History",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.walletHistoryScreen);
                  },
                  child: CustomText(
                    text: "More...",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Transaction List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 20.h),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildTransactionItem(
                    name: "Jeorge Mayank",
                    transactionId: "374364736",
                    date: "21 April 2025",
                    amount: "\$ 23",
                    imageUrl: "https://i.pravatar.cc/150?img=${index + 10}",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Balance info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Available Balance",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "\$",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    text: "2652",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),

          // Right side - Action buttons
          Column(
            children: [
              _buildActionButton(
                text: "Withdraw Now",
                onTap: () {
                  // Handle withdraw
                },
              ),
              SizedBox(height: 10.h),
              _buildActionButton(
                text: "Deposit Now",
                onTap: () {
                  // Handle deposit
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String name,
    required String transactionId,
    required String date,
    required String amount,
    required String imageUrl,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2.w,
              ),
            ),
            child: CustomNetworkImage(
              imageUrl: imageUrl,
              height: 50.h,
              width: 50.w,
              boxShape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 12.w),

          // Transaction Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: "Transition id : $transactionId",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: date,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

          // Amount
          CustomText(
            text: amount,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
