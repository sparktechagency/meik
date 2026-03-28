import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                CustomTextField(
                    showShadow: false,
                    controller: controller.currentPasswordController,
                    labelText: "Current Password",
                    hintText: "Enter old password",
                    isPassword: true,
                    contentPaddingVertical: 14.h,
                    borderColor: Color(0xff592B00),
                    hintextColor: Colors.black,
                    filColor: Colors.white),
                CustomTextField(
                    showShadow: false,
                    controller: controller.newPasswordController,
                    labelText: "New Password",
                    hintText: "Enter new password",
                    isPassword: true,
                    contentPaddingVertical: 14.h,
                    borderColor: Color(0xff592B00),
                    hintextColor: Colors.black,
                    filColor: Colors.white),
                CustomTextField(
                    showShadow: false,
                    controller: controller.confirmPasswordController,
                    labelText: "Confirm Password",
                    hintText: "Re-enter new password",
                    isPassword: true,
                    contentPaddingVertical: 14.h,
                    borderColor: Color(0xff592B00),
                    hintextColor: Colors.black,
                    filColor: Colors.white),
                Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(text: "Forget Password")),
                Spacer(),
                CustomButton(
                    title: "Update Password",
                    loading: controller.isLoadingChangePassword,
                    onpress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                    text: "Update password",
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w600,
                                    top: 20.h,
                                    bottom: 12.h),
                                Divider(),
                                SizedBox(height: 12.h),
                                CustomText(
                                  maxline: 2,
                                  bottom: 20.h,
                                  text: "Do you want to sure change your password?",
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                          height: 50.h,
                                          title: "Cancel",
                                          onpress: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.transparent,
                                          fontSize: 11.h,
                                          loaderIgnore: true,
                                          boderColor: Colors.black,
                                          titlecolor: Colors.black),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                          loading: controller.isLoadingChangePassword,
                                          loaderIgnore: true,
                                          height: 50.h,
                                          title: "Yes",
                                          onpress: () {
                                            Navigator.pop(context);
                                            controller.changePassword();
                                          },
                                          fontSize: 11.h),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
                SizedBox(height: 80.h)
              ],
            ),
          );
        },
      ),
    );
  }
}
