import 'package:danceattix/controllers/payment_controller.dart';
import 'package:danceattix/controllers/wallet_controller.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/helper/time_format_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

import 'package:danceattix/controllers/payment_controller.dart';
import 'package:danceattix/controllers/wallet_controller.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/helper/time_format_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_text.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WalletController _walletController = Get.find<WalletController>();

  // ✅ ScrollController যোগ করা হয়েছে pagination-এর জন্য
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_walletController.balance.isEmpty) {
        _walletController.balanceGet();
      }
      if (_walletController.transactions.isEmpty) {
        _walletController.transactionGet();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _walletController.transactionMore();
      }
    });
  }

  @override
  void dispose() {
    // ✅ Memory leak এড়াতে dispose করা হয়েছে
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220.h,
              floating: false,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.bgColor,
              title: CustomText(text: 'Wallet', fontSize: 22.sp),
              centerTitle: true,
              leading: IconButton(
                icon: Assets.icons.back.svg(height: 24.h, width: 24.w),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: "Overview",
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 16.h),
                        _buildBalanceCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            await _walletController.balanceGet();
            await _walletController.transactionGet();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

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
                        text: "More",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Expanded(
                  child: GetBuilder<WalletController>(
                    builder: (controller) {
                      // ✅ Initial loading
                      if (controller.isTransactionLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.transactions.isEmpty) {
                        return Center(
                          child: CustomText(
                            text: "No transactions yet",
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 20.h),

                        // ✅ Load more indicator-এর জন্য +1
                        itemCount: controller.transactions.length +
                            (controller.isTransactionLoadingMore ? 1 : 0),

                        itemBuilder: (context, index) {
                          // ✅ শেষ item হলে loading indicator দেখাবে
                          if (index == controller.transactions.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final transaction = controller.transactions[index];
                          return _buildTransactionItem(
                            name: transaction.user?.fullName ?? 'N/A',
                            transactionId: transaction.transectionType ?? 'N/A',
                            date: transaction.createdAt ?? 'N/A',
                            amount: "\$ ${transaction.amount}",
                            imageUrl: '',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return GetBuilder<WalletController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left — Balance info
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
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4.w),
                      // FIX 6: Show shimmer placeholder while loading
                      controller.isLoading
                          ? Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: SizedBox(
                          width: 80.w,
                          height: 32.h,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      )
                          : CustomText(
                        text: controller.balance,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),

              // Right — Action buttons
              Column(
                children: [
                  _buildActionButton(
                    text: "Withdraw Now",
                    onTap: () {
                      // TODO: handle withdraw
                    },
                  ),
                  SizedBox(height: 10.h),
                  _buildActionButton(
                    text: "Deposit Now",
                    onTap: _showDepositBottomSheet,
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

  void _showDepositBottomSheet() {
    final TextEditingController amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0).copyWith(
            // FIX 7: viewInsets padding applied correctly so keyboard
            // doesn't cover the bottom sheet content.
            bottom: MediaQuery.of(context).viewInsets.bottom + 40.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              CustomText(
                text: "Deposit Amount",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),

              SizedBox(height: 20.h),

              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 8.w),
                    child: CustomText(
                      text: "\$",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
                  hintText: "Enter amount",
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Quick-select chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [10, 50, 100, 200, 500].map((amount) {
                  return GestureDetector(
                    onTap: () => amountController.text = amount.toString(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: CustomText(
                        text: "\$$amount",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 28.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final amount = amountController.text.trim();
                    if (amount.isEmpty || double.tryParse(amount) == null) {
                      return;
                    }
                    Navigator.pop(context);
                    Get.find<PaymentController>().makePayment(price: amount);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: CustomText(
                    text: "Deposit Now",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
            // FIX 9: withOpacity is deprecated — use withValues instead
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
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
                // FIX 10: Typo "Transition" → "Transaction"
                CustomText(
                  text: "Transaction: $transactionId",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: TimeFormatHelper.timeWithAMPM(DateTime.parse(date)),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),

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