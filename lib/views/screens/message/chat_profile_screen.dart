import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class ChatProfileScreen extends StatelessWidget {
  const ChatProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CustomNetworkImage(
                  height: 48.h,
                  width: 48.w,
                  boxShape: BoxShape.circle,
                  imageUrl:
                  "https://randomuser.me/api/portraits/men/10.jpg",
                )),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  child: CustomText(
                      maxline: 3,
                      textAlign: TextAlign.start,
                      color: Colors.black,
                      text: "Cat Travel Bag(Preety Zinnat)"),
                ),


                CustomText(
                    text: " Last active 23 hr ago", fontSize: 9.h),
              ],
            ),


          ],
        ),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [

            SizedBox(height: 18.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.mediaScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffFEF4EA)
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    children: [

                      Assets.icons.mediaIcon.svg(),

                      CustomText(text: "Media", color: Colors.black, left: 12.w, fontSize: 16.h)


                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 18.h),

            GestureDetector(
              onTap: () {


                TextEditingController amonCtrl =
                TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                              text: "Are you sure to Report this user?",
                              fontSize: 14.h,
                              fontWeight: FontWeight.w600,
                              top: 29.h,
                              bottom: 20.h,
                              color: Color(0xff592B00)),
                          Divider(),
                          SizedBox(height: 12.h),
                          CustomTextField(
                            shadowNeed: false,
                              controller: amonCtrl,
                              labelText: "Reason of Report",
                              hintText: "Reason"),
                          SizedBox(height: 12.h),
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
                                    boderColor: AppColors
                                        .primaryColor,
                                    titlecolor: AppColors
                                        .primaryColor),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    loading: false,
                                    loaderIgnore: true,
                                    height: 50.h,
                                    title: "Report",
                                    onpress: () {
                                      Get.toNamed(AppRoutes.messageScreen);
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


              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xffFEF4EA)
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    children: [

                      Assets.icons.reportUserIcon.svg(),

                      CustomText(text: "Report This User", color: Colors.red, left: 12.w, fontSize: 16.h)


                    ],
                  ),
                ),
              ),
            ),



            SizedBox(height: 18.h),


            GestureDetector(
              onTap: () {



                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                              text: "Are you sure to Block this user?",
                              fontSize: 14.h,
                              fontWeight: FontWeight.w600,
                              top: 29.h,
                              bottom: 20.h,
                              color: Color(0xff592B00)),
                          Divider(),
                          SizedBox(height: 12.h),

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
                                    boderColor: AppColors
                                        .primaryColor,
                                    titlecolor: AppColors
                                        .primaryColor),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                    loading: false,
                                    loaderIgnore: true,
                                    height: 50.h,
                                    title: "Block",
                                    onpress: () {
                                      Get.toNamed(AppRoutes.messageScreen);
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



              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xffFEF4EA)
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    children: [

                      Assets.icons.blockUserIcon.svg(),

                      CustomText(text: "Block This User", color: Colors.red, left: 12.w, fontSize: 16.h)


                    ],
                  ),
                ),
              ),
            )




          ],
        ),
      ),


    );
  }
}
