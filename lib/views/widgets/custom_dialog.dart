import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_constants/app_colors.dart';
import 'custom_button.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class CustomDialog extends StatelessWidget {
  final TextEditingController? controller;

  const CustomDialog({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
            text: "Make Offer",
            fontSize: 16.h,
            fontWeight: FontWeight.w600,
            top: 29.h,
            bottom: 20.h),

        Row(
          children: [
            CustomNetworkImage(
              borderRadius: BorderRadius.circular(10.r),
                imageUrl:
                    "https://www.irealife.com/cdn/shop/articles/Top_10_Spring_Dresses_for_Women.jpg?v=1727179480",
                height: 49.h,
                width: 49.w),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "Shift Dress",
                    fontSize: 16.h,
                    fontWeight: FontWeight.w500),
                CustomText(text: "Price: \$25", fontSize: 10.h),
              ],
            ),
          ],
        ),

        SizedBox(height: 12.h),
        CustomTextField(
            shadowNeed: false,
            controller: controller ?? TextEditingController(),
            labelText: "Offer your price",
            hintText: "Enter Price"),
        SizedBox(height: 12.h),

        CustomButton(
            loading: false,
            loaderIgnore: true,
            height: 50.h,
            title: "Make Offer",
            onpress: () {},
            fontSize: 11.h),

        // Row(
        //   children: [
        //     Expanded(
        //       flex: 1,
        //       child: CustomButton(
        //           height: 50.h,
        //           title: "Cancel",
        //           onpress: () {},
        //           color: Colors.transparent,
        //           fontSize: 11.h,
        //           loaderIgnore: true,
        //           boderColor: AppColors
        //               .primaryColor,
        //           titlecolor: AppColors
        //               .primaryColor),
        //     ),
        //     SizedBox(width: 8.w),
        //     Expanded(
        //       flex: 1,
        //       child: CustomButton(
        //           loading: false,
        //           loaderIgnore: true,
        //           height: 50.h,
        //           title: "Offer",
        //           onpress: () {},
        //           fontSize: 11.h),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
