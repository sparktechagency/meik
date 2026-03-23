import 'package:country_code_picker/country_code_picker.dart';
import 'package:danceattix/controllers/auth_controller.dart';
import 'package:danceattix/views/widgets/custom_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
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

  // Translated strings
  String _agreeWith = 'Agree with ';
  String _termsOfServices = 'Terms of Services';
  String _and = ' & ';
  String _privacyPolicy = 'Privacy Policy';
  String _haveAccount = 'Have any account ?  ';
  String _login = 'Login';
  String _phoneHint = 'e.g. 123 456 7890';

  @override
  void initState() {
    super.initState();
    _translateStaticStrings();
  }

  Future<void> _translateStaticStrings() async {
    final s = TranslationService();
    final results = await Future.wait([
      s.translate('Agree with '),
      s.translate('Terms of Services'),
      s.translate(' & '),
      s.translate('Privacy Policy'),
      s.translate('Have any account ?  '),
      s.translate('Login'),
      s.translate('e.g. 123 456 7890'),
    ]);

    if (mounted) {
      setState(() {
        _agreeWith = results[0];
        _termsOfServices = results[1];
        _and = results[2];
        _privacyPolicy = results[3];
        _haveAccount = results[4];
        _login = results[5];
        _phoneHint = results[6];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
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

                // Form Fields
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        showShadow: false,
                        controller: _controller.firstNameController,
                        hintText: "First Name",
                        prefixIcon: Assets.icons.user.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      CustomTextField(
                        showShadow: false,
                        controller: _controller.lastNameController,
                        hintText: "Last Name",
                        prefixIcon: Assets.icons.user.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      CustomTextField(
                        showShadow: false,
                        controller: _controller.emailController,
                        hintText: "Enter E-mail",
                        prefixIcon: Assets.icons.email.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isEmail: true,
                      ),

                      _buildPhoneField(),

                      CustomTextField(
                        showShadow: false,
                        controller: _controller.locationController,
                        hintText: "Address",
                        prefixIcon: Assets.icons.phoneNo.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                      ),

                      CustomTextField(
                        showShadow: false,
                        controller: _controller.passwordController,
                        hintText: "Enter Password",
                        prefixIcon: Assets.icons.lock.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isPassword: true,
                      ),

                      CustomTextField(
                        showShadow: false,
                        controller: _controller.confirmPassController,
                        hintText: "Confirm Password",
                        prefixIcon: Assets.icons.lock.svg(
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.hitTextColorA5A5A5,
                        ),
                        isPassword: true,
                      ),

                      // Terms and Conditions
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
                                padding: EdgeInsets.only(top: 5.h),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: AppColors.textColorA0A0A,
                                      fontSize: 12.sp,
                                      fontFamily: "Poppins",
                                    ),
                                    children: [
                                      TextSpan(text: _agreeWith),
                                      TextSpan(
                                        text: _termsOfServices,
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                      TextSpan(text: _and),
                                      TextSpan(
                                        text: _privacyPolicy,
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
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
                          return controller.isLoadingRegister
                              ? CustomLoader()
                              : CustomButton(
                            title: "Register",
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                controller.register();
                              }
                            },
                          );
                        },
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
                            TextSpan(text: _haveAccount),
                            TextSpan(
                              text: _login,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.logInScreen);
                                },
                            ),
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
                  // ✅ Translated hint
                  hintText: _phoneHint,
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
}