import 'package:danceattix/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';


class OptScreen extends StatefulWidget {
  const OptScreen({super.key});

  @override
  State<OptScreen> createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  final AuthController _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 62.h),

              Assets.images.logo.image(height: 112.h, width: 133.w),

              SizedBox(height: 60.h),

              /// <<< ============><>>> Login text flied  << < ==============>>>
              Column(
                children: [
                  // TODO: Pin Code TextField
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 24.w),
                    child: PinCodeTextField(
                      useHapticFeedback: true,
                      appContext: context,
                      length: 4,
                      controller: _controller.otpController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        inactiveColor: AppColors.borderColor,
                        selectedColor: AppColors.borderColor,
                        activeColor: AppColors.borderColor,
                        disabledColor: AppColors.borderColor,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: false,
                      onChanged: (value) {},
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Didn't get the code?"),
                      CustomText(text: "Resend", color: AppColors.primaryColor),
                    ],
                  ),

                  SizedBox(height: 120.h),

                  GetBuilder<AuthController>(
                    builder: (controller) {
                      return controller.isLoadingOtp ? CustomLoader() : CustomButton(
                        title: "Verify",
                        onpress: () async {
                          final String verificationType =
                              Get.arguments as String;

                          final bool success = await controller.verifyOTP(
                            verificationType: verificationType,
                          );

                          if (success) {
                            if (verificationType == "registration") {
                              Get.offAllNamed(AppRoutes.logInScreen);
                              return;
                            } else {
                              Get.offAllNamed(AppRoutes.resetPasswordScreen);
                              return;
                            }
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 160.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
