import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/config/app_route.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';


class MakePayment extends StatelessWidget {
  const MakePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm Payment"),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Product Price", color: Colors.black),
                CustomText(text: "\$ 30", color: Colors.red),
              ],
            ),


            SizedBox(height: 8.h),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Platform Charge", color: Colors.black),
                CustomText(text: "\$ 10", color: Colors.red),
              ],
            ),

            SizedBox(height: 8.h),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Delivery Charge", color: Colors.black),
                CustomText(text: "\$ 10", color: Colors.red),
              ],
            ),

            SizedBox(height: 4.h),

            Divider(),


            SizedBox(height: 6.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "total Payment", color: Colors.black),
                CustomText(text: "\$ 50", color: Colors.red),
              ],
            ),




            Spacer(),



            CustomButton(title: "Make Payment", onpress: (){
              Get.toNamed(AppRoutes.confirmed);
            }),


            SizedBox(height: 100.h)

          ],
        ),
      ),
    );
  }
}
