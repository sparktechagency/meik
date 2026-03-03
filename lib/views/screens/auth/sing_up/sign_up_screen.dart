import 'package:country_code_picker/country_code_picker.dart';
import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/views/widgets/custom_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _controller = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool isChecked = false;
  String selectedCountryCode = "+1";
  String selectedCountryFlag = "US";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhiteFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Back Button
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 16.h),
                  child: Align(
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
                ),

                SizedBox(height: 16.h),

                // Header Section
                CustomText(
                  text: "Create Account",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColorA0A0A,
                ),

                SizedBox(height: 12.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: CustomText(
                    text: "Enter this information properly and get excited service properly !!!",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hitTextColorA5A5A5,
                    textAlign: TextAlign.center,
                    maxline: 2,
                  ),
                ),

                SizedBox(height: 24.h),

                // Form Fields Container
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      // Name Field
                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.firstNameController,
                        hintText: "First Name",
                        prefixIcon: Assets.icons.user.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.lastNameController,
                        hintText: "Last Name",
                        prefixIcon: Assets.icons.user.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      // Email Field
                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.emailController,
                        hintText: "Enter E-mail",
                        prefixIcon: Assets.icons.email.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isEmail: true,
                      ),

                      // Phone Field with Country Code
                      _buildPhoneField(),

                      // Address Field
                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.locationController,
                        hintText: "Address",
                        prefixIcon: Assets.icons.phoneNo.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      // Password Field
                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.passwordController,
                        hintText: "Enter Password",
                        prefixIcon: Assets.icons.lock.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isPassword: true,
                      ),

                      // Confirm Password Field
                      CustomTextField(
                        shadowNeed: false,
                        controller: _controller.confirmPassController,
                        hintText: "Confirm Password",
                        prefixIcon: Assets.icons.lock.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isPassword: true,
                      ),

                      // Terms and Conditions Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(-12, -8),
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              activeColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Transform.translate(
                              offset: const Offset(-12, 0),
                              child: Padding(
                                padding:  EdgeInsets.only(top: 5.h),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: AppColors.textColorA0A0A,
                                      fontSize: 12.sp,
                                      fontFamily: "Poppins",
                                    ),
                                    children: [
                                      const TextSpan(text: 'Agree with '),
                                      TextSpan(
                                        text: 'Terms of Services',
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Open Terms of Service
                                          },
                                      ),
                                      const TextSpan(text: ' & '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Open Privacy Policy
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Register Button
                      GetBuilder<AuthController>(
                        builder: (controller) {
                          return controller.isLoadingRegister ? CustomLoader() : CustomButton(
                            title: "Register",
                            onpress: () {
                              if(_formKey.currentState!.validate()){
                                controller.register();
                              }
                              //_showSuccessDialog(context);
                            },
                          );
                        }
                      ),

                      SizedBox(height: 20.h),

                      // Login Link
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.textColorA0A0A,
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                          ),
                          children: [
                            const TextSpan(text: 'Have any account ?  '),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.logInScreen);
                                },
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          // Country Code Picker
          Container(
            height: 58.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: CountryCodePicker(
              onChanged: (CountryCode countryCode) {
                setState(() {
                  selectedCountryCode = countryCode.dialCode ?? "+1";
                  selectedCountryFlag = countryCode.code ?? "US";
                });
              },
              initialSelection: 'US',
              favorite: const ['+1', 'US', '+7', 'RU', '+77', 'KZ'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              padding: EdgeInsets.zero,
              textStyle: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textColorA0A0A,
                fontFamily: "Poppins",
              ),
              flagWidth: 24.w,
            ),
          ),
          SizedBox(width: 8.w),
          // Phone Number Field
          Expanded(
            child: Container(
              height: 58.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: TextFormField(
                controller: _controller.phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textColorA0A0A,
                ),
                decoration: InputDecoration(
                  hintText: "e.g. 123 456 7890",
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.hitTextColorA5A5A5,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Decorative circles
                    ...List.generate(6, (index) {
                      return Positioned(
                        top: (index % 2 == 0) ? 10.h : 60.h,
                        left: (index % 3 == 0) ? 20.w : (index % 3 == 1) ? 80.w : 140.w,
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Congratulation Text
                CustomText(
                  text: "Congratulation",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColorA0A0A,
                ),

                SizedBox(height: 12.h),

                // Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: "Your account create successfully. Are you want to setup profile now ?",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hitTextColorA5A5A5,
                    textAlign: TextAlign.center,
                    maxline: 3,
                  ),
                ),

                SizedBox(height: 24.h),

                // Buttons
                Row(
                  children: [
                    // Later Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.logInScreen);
                        },
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "Later",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColorA0A0A,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Yes Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.uploadNIDScreen);
                        },
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "Yes",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  void dispose() {
      _controller.firstNameController.clear();
      _controller.lastNameController.clear();
      _controller.emailController.clear();
      _controller.phoneController.clear();
      _controller.locationController.clear();
      _controller.passwordController.clear();
      _controller.confirmPassController.clear();
    super.dispose();
  }
}
