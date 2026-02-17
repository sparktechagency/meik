import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 30.h),


            _customCartItem(
                title: "Change Password",
                icon: Assets.icons.lock.svg(color: Colors.black),
                onTap: () {
                  Get.toNamed(AppRoutes.changePasswordScreen);
                }),


            _customCartItem(
                title: "About Us",
                icon: Assets.icons.aboutUs.svg(),
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                    "title" : "About Us",
                  });
                }),



            _customCartItem(
                title: "Privacy Policy",
                icon: Assets.icons.privacyPolicyIcon.svg(),
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                    "title" : "Privacy Policy",
                  });
                }),



            _customCartItem(
                title: "Terms of service",
                icon: Assets.icons.termandConditionIcon.svg(),
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                    "title" : "Terms of service",
                  });
                }),




            _customCartItem(
                title: "Buyer protection",
                icon: Assets.icons.buyerProtection.svg(),
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                    "title" : "Buyer protection",
                  });
                }),



            Spacer(),


            CustomButton(
                color: Colors.red,
                boderColor: Colors.red,
                title: "Delete Account", onpress: () {

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                            text: "Delete Account",
                            fontSize: 16.h,
                            fontWeight: FontWeight.w600,
                            top: 20.h,
                            bottom: 12.h,
                            color: Colors.red),
                        Divider(),
                        SizedBox(height: 12.h),
                        CustomText(
                          maxline: 2,
                          bottom: 20.h,
                          text: "Are you sure want to delete your Account?",
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
                                  color: Colors.red,
                                  boderColor: Colors.red,
                                  height: 50.h,
                                  title: "Yes, Delete",
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

  Widget _customCartItem(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            child: Row(
              children: [
                icon,
                CustomText(text: "$title", color: Colors.black, left: 16.w),
                Spacer(),
                Assets.icons.rightArrow.svg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
