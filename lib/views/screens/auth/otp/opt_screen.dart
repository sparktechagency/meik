import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class OptScreen extends StatelessWidget {
  OptScreen({super.key});

  final TextEditingController pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Verify"),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 62.h),

              Assets.images.logo.image(height: 112.h, width: 133.w),

              SizedBox(height: 60.h),


              /// <<< ============><>>> Login text flied  << < ==============>>>

              Column(
                children: [

                  // TODO: Pin Code TextField

                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: pinCtrl,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 60,
                      fieldWidth: 50,
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





                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Didn't get the code?"),
                      CustomText(text: "Resend", color: AppColors.primaryColor)
                    ],
                  ),

                  SizedBox(height: 120.h),

                  CustomButton(title: "Verify", onpress: () {
                    Get.arguments["screenType"] == "Sign up" ?
                    Get.toNamed(AppRoutes.logInScreen)  :
                    Get.toNamed(AppRoutes.resetPasswordScreen);
                  }),
                  SizedBox(height: 160.h),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
