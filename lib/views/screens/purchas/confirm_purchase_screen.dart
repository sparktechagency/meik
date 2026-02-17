import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class ConfirmPurchaseScreen extends StatefulWidget {
   ConfirmPurchaseScreen({super.key});

  @override
  State<ConfirmPurchaseScreen> createState() => _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
  TextEditingController deliveryAddress = TextEditingController();

  @override
  void initState() {
    deliveryAddress.text = "Mohakhali, Dhaka, Bangladesh";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Confirm Purchase"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl:
                      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                  height: 95.h,
                  width: 80.w,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Cat Travel Bag (Used)",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    CustomText(text: "30\$", fontSize: 18.h, color: Colors.red),
                    Row(
                      children: [
                        CustomNetworkImage(
                            imageUrl: "https://i.pravatar.cc/150?img=3",
                            height: 34.h,
                            width: 34.w,
                            boxShape: BoxShape.circle),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: " Sarah Rahman", color: Colors.black87),
                            Row(
                              children: [
                                CustomText(
                                    text: "⭐ 4.8 | Verified Seller",
                                    color: Colors.black87),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Delivery Address", fontSize: 16.h, color: Colors.black),
                CustomText(text: "Edit", color: Colors.red),
              ],
            ),
            TextField(
              controller: deliveryAddress,
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            CustomText(
              text: "Delivery Methods",
              fontSize: 16.h,
              color: Colors.black,
              top: 10.h,
            ),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "•  Courier delivery (\$15)",
                bottom: 7.h),
            Divider(),
            CustomText(
              text: "Payment Methods",
              fontSize: 16.h,
              color: Colors.black,
              top: 10.h,
            ),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "•  Pay via PetAttix (Escrow) (Recommended)",
                bottom: 7.h),
            Divider(),
            CustomText(
              text: "Refund & Return Policy (Collapsible Box)",
              fontSize: 16.h,
              color: Colors.black,
              top: 10.h,
            ),
            CustomText(
                text: "refund Available", color: Colors.black, fontSize: 13.h),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "• If item is damaged, fake, or not as described",
                bottom: 7.h,
                fontSize: 12.h,
                top: 8.h),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "• Buyer pays return shipping",
                bottom: 7.h,
                fontSize: 12.h),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "• Full refund processed after seller confirms return",
                bottom: 7.h,
                fontSize: 12.h),
            CustomText(
                color: Color(0xff1C1C1C),
                text: "• No returns for “change of mind” or personal dislike",
                bottom: 7.h,
                fontSize: 12.h),
            CustomText(
                text: "View Full Return Policy..",
                fontSize: 15.h,
                color: AppColors.primaryColor,
                top: 10.h,
                bottom: 120.h),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      height: 26.h,
                      title: "Cancel",
                      onpress: () {},
                      color: Colors.transparent,
                      fontSize: 11.h,
                      loaderIgnore: true,
                      boderColor: AppColors.primaryColor,
                      titlecolor: AppColors.primaryColor),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                      loading: false,
                      loaderIgnore: true,
                      height: 26.h,
                      title: "Confirm",
                      onpress: () {
                        Get.toNamed(AppRoutes.makePayment);
                      },
                      fontSize: 11.h),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
