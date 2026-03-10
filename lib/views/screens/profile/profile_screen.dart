import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Change this to test verified/unverified state
  final bool isVerified = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),

            // Profile Image with border
            GetBuilder<UserController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.profileInformationScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: controller.userData?.profileImage ?? '',
                      height: 90.h,
                      width: 90.w,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                );
              }
            ),

            SizedBox(height: 16.h),

            // Name
            GetBuilder<UserController>(
              builder: (controller) {
                return CustomText(
                  text: controller.userData?.fullName ?? 'N/A',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                );
              }
            ),

            SizedBox(height: 12.h),

            // Verified/Verify Now Badge
            _buildVerificationBadge(),

            SizedBox(height: 40.h),

            // Menu Items
            _buildMenuItem(
              icon: Icons.person_outline,
              title: "Profile Information",
              onTap: () {
                Get.toNamed(AppRoutes.profileInformationScreen);
              },
            ),

            _buildMenuItem(
              icon: Icons.translate,
              title: "Translation",
              onTap: () {
                // Navigate to translation screen
              },
            ),

            _buildMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              title: "Wallet",
              onTap: () {
                Get.toNamed(AppRoutes.walletScreen);
              },
            ),

            _buildMenuItem(
              icon: Icons.headset_mic_outlined,
              title: "Admin Support",
              onTap: () {
                // Navigate to admin support
              },
            ),

            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {
                Get.toNamed(AppRoutes.settingScreen);
              },
            ),

            _buildMenuItem(
              icon: Icons.logout_outlined,
              title: "Logout",
              showDivider: false,
              onTap: () {
                _showLogoutDialog(context);
              },
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationBadge() {
    if (isVerified) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified,
              color: Colors.white,
              size: 18.sp,
            ),
            SizedBox(width: 6.w),
            CustomText(
              text: "Verified",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.uploadNIDScreen);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: CustomText(
            text: "Verify now",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: Colors.black87,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: Colors.black87,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                textAlign: TextAlign.start,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              CustomText(
                text: "Log Out",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(height: 12.h),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 12.h),
              CustomText(
                text: "Are you sure you want to logout?",
                fontSize: 14.sp,
                color: Colors.grey,
                maxline: 2,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 48.h,
                      title: "Cancel",
                      onpress: () {
                        Get.back();
                      },
                      color: Colors.transparent,
                      fontSize: 14.sp,
                      loaderIgnore: true,
                      boderColor: Colors.grey.shade400,
                      titlecolor: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      height: 48.h,
                      title: "Logout",
                      onpress: () {
                        Get.offAllNamed(AppRoutes.logInScreen);
                      },
                      color: Colors.red,
                      boderColor: Colors.red,
                      fontSize: 14.sp,
                      loaderIgnore: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
