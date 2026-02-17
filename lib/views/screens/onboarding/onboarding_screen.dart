import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Order",
      "description": "\"Order effortlessly on Bazario – where convenience meets variety, bringing your favorites to your doorstep.\"",
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Payment",
      "description": "\"Seamless payments, secure transactions—Bazario makes shopping effortless and safe with every purchase.\"",
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Delivered",
      "description": "\"Bazario: Bringing your products to your doorstep, fast, safe, and always on time!\"",
      "image": "assets/images/onboarding3.png"
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhiteFFFFFF,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    title: _onboardingData[index]["title"]!,
                    description: _onboardingData[index]["description"]!,
                    imagePath: _onboardingData[index]["image"]!,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: Row(
                children: [
                  // Get Started Button
                  CustomButton(
                    loaderIgnore: true,
                    title: _currentPage == _onboardingData.length - 1 ? "Get start" : "Next",
                    onpress: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        // Last page - navigate to login
                        Get.offAllNamed(AppRoutes.logInScreen);
                      } else {
                        // Go to next page
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    width: 140,
                    borderRadius: 30.r,
                  ),
                  const Spacer(),
                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 60.h),
          // Title
          CustomText(
            text: title,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 40.h),
          // Illustration
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background blob shape
                Container(
                  width: 300.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150.r),
                      topRight: Radius.circular(150.r),
                      bottomLeft: Radius.circular(100.r),
                      bottomRight: Radius.circular(150.r),
                    ),
                  ),
                ),
                // Image
                Image.asset(
                  imagePath,
                  height: 280.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Description
          CustomText(
            text: description,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.hitTextColorA5A5A5,
            textAlign: TextAlign.center,
            maxline: 4,
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 6.w),
      height: 8.h,
      width: _currentPage == index ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
