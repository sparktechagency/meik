import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/core/config/app_route.dart';
import 'package:danceattix/views/widgets/custom_image_avatar.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Profile Information'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<UserController>(
          builder: (controller) {
            final user = controller.userData;
            return Column(
              children: [
                SizedBox(height: 8.h),
                CustomImageAvatar(
                  showBorder: true,
                  radius: 54.r,
                  image: user?.image ?? '',
                ),
                SizedBox(height: 24.h),
                _buildInfoCard(
                  title: 'Personal Information',
                  rows: [
                    _buildInfoRow(label: 'Name', value: user?.fullName ?? 'N/A'),
                    _buildInfoRow(label: 'Email', value: user?.email ?? 'N/A'),
                    _buildInfoRow(label: 'Phone no', value: user?.phone ?? 'N/A'),
                    _buildInfoRow(label: 'Address', value: user?.address ?? 'N/A'),
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            );
          }
        ),
      ),
    );
  }

  // ── Info Card Base ─────────────────────────────────────────────────────────
  Widget _buildInfoCard({required String title, required List<Widget> rows}) {
    return CustomContainer(
      color: AppColors.bgColor,
      bordersColor: AppColors.borderColor,
      radiusAll: 12.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(width: 8.h),
                CustomText(text: title),
                Spacer(),
                TextButton(onPressed: (){
                  Get.toNamed(AppRoutes.editProfileScreen);
                }, child: CustomText(
                  textDecoration: TextDecoration.underline,
                  text: 'Edit', fontSize: 12.sp, color: AppColors.primaryColor, fontWeight: FontWeight.w600,
                )),
              ],
            ),
          ),
          //const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
            child: Column(spacing: 8.h, children: rows),
          ),
        ],
      ),
    );
  }

  // ── Row Helpers ────────────────────────────────────────────────────────────
  Widget _buildInfoRow({
    required String label,
    String? value,
    Widget? valueWidget,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: CustomText(
            text: label,
            fontSize: 12.sp,
            textAlign: TextAlign.start,
          ),
        ),
        CustomText(text: ':', fontSize: 12.sp),
        SizedBox(width: 32.w),
        Expanded(
          child:
              valueWidget ??
              CustomText(
                enableAutoTranslate: false,
                text: value ?? '',
                fontSize: 12.sp,
                textAlign: TextAlign.start,
              ),
        ),
      ],
    );
  }

}
