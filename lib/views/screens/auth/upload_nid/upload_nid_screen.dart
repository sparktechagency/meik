import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class UploadNIDScreen extends StatefulWidget {
  const UploadNIDScreen({super.key});

  @override
  State<UploadNIDScreen> createState() => _UploadNIDScreenState();
}

class _UploadNIDScreenState extends State<UploadNIDScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _nidFrontImage;
  File? _nidBackImage;
  File? _passportFrontImage;
  File? _passportBackImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nidController.dispose();
    _passportController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        switch (type) {
          case 'nid_front':
            _nidFrontImage = File(image.path);
            break;
          case 'nid_back':
            _nidBackImage = File(image.path);
            break;
          case 'passport_front':
            _passportFrontImage = File(image.path);
            break;
          case 'passport_back':
            _passportBackImage = File(image.path);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhiteFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.bgColorWhiteFFFFFF,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
              color: AppColors.textColorA0A0A,
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: _tabController.index == 0 ? "Upload NID" : "Upload Passport",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textColorA0A0A,
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          //   decoration: BoxDecoration(
          //     color: AppColors.bgColor,
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: TabBar(
          //     controller: _tabController,
          //     indicator: BoxDecoration(
          //       color: AppColors.primaryColor,
          //       borderRadius: BorderRadius.circular(12.r),
          //     ),
          //     labelColor: Colors.white,
          //     unselectedLabelColor: AppColors.textColorA0A0A,
          //     labelStyle: TextStyle(
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w600,
          //       fontFamily: "Poppins",
          //     ),
          //     unselectedLabelStyle: TextStyle(
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //       fontFamily: "Poppins",
          //     ),
          //     tabs: const [
          //       Tab(text: "NID"),
          //       Tab(text: "Passport"),
          //     ],
          //   ),
          // ),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // NID Tab
                _buildNIDTab(),
                // Passport Tab
                _buildPassportTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNIDTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // NID Number Label
          CustomText(
            text: "NID No",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          // NID Number Input
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _nidController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColorA0A0A,
                fontFamily: "Poppins",
              ),
              decoration: InputDecoration(
                hintText: "3264 35465 341654",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.hitTextColorA5A5A5,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Upload NID Front
          CustomText(
            text: "Upload NID front",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          _buildUploadBox(
            image: _nidFrontImage,
            onTap: () => _pickImage('nid_front'),
          ),

          SizedBox(height: 24.h),

          // Upload NID Back
          CustomText(
            text: "Upload NID back",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          _buildUploadBox(
            image: _nidBackImage,
            onTap: () => _pickImage('nid_back'),
          ),

          SizedBox(height: 40.h),

          // Skip for now
          Center(
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(AppRoutes.logInScreen);
              },
              child: CustomText(
                text: "Skip for now",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.hitTextColorA5A5A5,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Save and Continue Button
          CustomButton(
            title: "Save and continue",
            onpress: () {
              Get.offAllNamed(AppRoutes.logInScreen);
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildPassportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          // Passport Number Label
          CustomText(
            text: "Passport No",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          // Passport Number Input
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _passportController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textColorA0A0A,
                fontFamily: "Poppins",
              ),
              decoration: InputDecoration(
                hintText: "3264 35465 341654",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.hitTextColorA5A5A5,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Upload Passport Front
          CustomText(
            text: "Upload passport front",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          _buildUploadBox(
            image: _passportFrontImage,
            onTap: () => _pickImage('passport_front'),
          ),

          SizedBox(height: 24.h),

          // Upload Passport Back
          CustomText(
            text: "Upload passport back",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textColorA0A0A,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          _buildUploadBox(
            image: _passportBackImage,
            onTap: () => _pickImage('passport_back'),
          ),

          SizedBox(height: 40.h),

          // Skip for now
          Center(
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(AppRoutes.logInScreen);
              },
              child: CustomText(
                text: "Skip for now",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.hitTextColorA5A5A5,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Save and Continue Button
          CustomButton(
            title: "Save and continue",
            onpress: () {
              Get.offAllNamed(AppRoutes.logInScreen);
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildUploadBox({File? image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.borderColor,
            style: BorderStyle.solid,
          ),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : CustomPaint(
                painter: DashedBorderPainter(
                  color: AppColors.borderColor,
                  strokeWidth: 1,
                  dashWidth: 8,
                  dashSpace: 4,
                  borderRadius: 12.r,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.bgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.upload_outlined,
                          size: 24.sp,
                          color: AppColors.textColorA0A0A,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: "Upload",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColorA0A0A,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// Custom Painter for Dashed Border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rRect);
    final Path dashPath = Path();

    for (final PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
