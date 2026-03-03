import 'package:danceattix/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  final AuthController _controller = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



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

              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: _controller.forgotEmailController,
                  hintText: "Email",
                  isEmail: true,
                  prefixIcon: Assets.icons.emailIcon.svg(),
                ),
              ),

              SizedBox(height: 120.h),

              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingForgot ? CustomLoader() : CustomButton(
                      title: "Send OTP",
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          controller.forgot();
                        }
                      });
                }
              ),

              SizedBox(height: 160.h)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.forgotEmailController.clear();
    super.dispose();
  }
}
