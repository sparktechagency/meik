import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:danceattix/views/widgets/custom_loader.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:danceattix/views/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final AuthController _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
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
                ),

                SizedBox(height: 40.h),

                // Logo
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Assets.images.logo.image(
                    height: 70.h,
                    width: 70.w,
                  ),
                ),

                SizedBox(height: 8.h),

                // BAZARIO Text
                CustomText(
                  text: "BAZARIO",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  letterSpacing: 2,
                ),

                SizedBox(height: 50.h),

                // Email TextField
                CustomTextField(
                  controller: _controller.loginEmailController,
                  hintText: "Enter email",
                  prefixIcon: Assets.icons.email.svg(
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.hitTextColorA5A5A5,
                  ),
                  isEmail: true,
                ),

                // Password TextField
                CustomTextField(
                  controller: _controller.loginPasswordController,
                  hintText: "Enter Password",
                  prefixIcon: Assets.icons.password.svg(
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.hitTextColorA5A5A5,
                  ),
                  isPassword: true,
                ),

                SizedBox(height: 8.h),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotScreen);
                    },
                    child: CustomText(
                      text: "Forgot Password",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      textDecoration: TextDecoration.none,
                    ),
                  ),
                ),

                SizedBox(height: 60.h),

                // Login Button
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return controller.isLoadingLogin ?
                    const CustomLoader() :
                         CustomButton(
                      title: "Lets go !!",
                      onpress: () => controller.login()
                    );
                  }
                ),

                SizedBox(height: 24.h),

                // Sign Up Link
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.textColorA0A0A,
                      fontSize: 14.sp,
                      fontFamily: "Poppins",
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account?  "),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.signUpScreen);
                          },
                      )
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _controller.loginEmailController.dispose();
  //   _controller.loginPasswordController.dispose();
  //   super.dispose();
  // }
}
