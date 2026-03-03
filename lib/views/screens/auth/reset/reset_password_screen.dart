import 'package:danceattix/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthController _controller = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Reset Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 62.h),

                Assets.images.logo.image(height: 112.h, width: 133.w),

                SizedBox(height: 60.h),

                /// <<< ============><>>> Login text flied  << < ==============>>>

                CustomTextField(
                    controller: _controller.resetPasswordController,
                    hintText: "New password",
                    prefixIcon: Assets.icons.lock.svg(),
                    isPassword: true),
                CustomTextField(
                    controller: _controller.newResetPasswordController,
                    hintText: "Confirm password",
                    prefixIcon: Assets.icons.lock.svg(),
                    isPassword: true),

                SizedBox(height: 130.h),

                GetBuilder<AuthController>(
                    builder: (controller) {
                      return controller.isLoadingReset ? CustomLoader() : CustomButton(
                          title: "Confirm",
                          onpress: () {
                            if (_formKey.currentState!.validate()) {
                              controller.resetPassword();
                            }
                          });
                    }
                ),


                SizedBox(height: 160.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
