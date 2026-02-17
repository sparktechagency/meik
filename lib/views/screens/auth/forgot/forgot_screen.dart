import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/config/app_route.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Forget Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 62.h),

              Assets.images.logo.image(height: 112.h, width: 133.w),

              SizedBox(height: 60.h),

              /// <<< ============><>>> Login text flied  << < ==============>>>

              CustomTextField(
                controller: emailCtrl,
                hintText: "Email",
                isEmail: true,
                prefixIcon: Assets.icons.emailIcon.svg(),
              ),

              SizedBox(height: 120.h),

              CustomButton(
                  title: "Send OTP",
                  onpress: () {
                    Get.toNamed(AppRoutes.optScreen,
                        arguments: {"screenType": "forget"});
                  }),

              SizedBox(height: 160.h)
            ],
          ),
        ),
      ),
    );
  }
}
