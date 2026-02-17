import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  TextEditingController currentPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController rePassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CustomTextField(
               shadowNeed: false,
                controller: currentPassCtrl,
                labelText: "Current Password",
                hintText: "Enter old password",
                isPassword: true,
                contentPaddingVertical: 14.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                filColor: Colors.white),
            CustomTextField(
                shadowNeed: false,
                controller: newPassCtrl,
                labelText: "New Password",
                hintText: "Enter new password",
                isPassword: true,
                contentPaddingVertical: 14.h,
                borderColor: Color(0xff592B00),
                hintextColor: Colors.black,
                filColor: Colors.white),
            CustomTextField(
                shadowNeed: false,
                controller: rePassCtrl,
                labelText: "Password",
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
                                      onpress: () {},
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
                                      loading: false,
                                      loaderIgnore: true,
                                      height: 50.h,
                                      title: "Yes",
                                      onpress: () {
                                        Get.back();
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
      ),
    );
  }
}
