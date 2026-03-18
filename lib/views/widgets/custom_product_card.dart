import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/app_constants/app_colors.dart';
import '../../global/custom_assets/assets.gen.dart';
import 'cachanetwork_image.dart';
import 'custom_button.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class CustomProductCard extends StatelessWidget {
  final int? index;
  final String? title;
  final String? price;
  final String? image;
  final String? progressStatus;
  final String? leftBtnName;
  final String? rightBtnName;
  final bool? isFavorite;
  final bool isHistory;
  final bool? isBookMarkNeed;
  final VoidCallback? onTap;

  const CustomProductCard(
      {super.key,
        this.index,
        this.title,
        this.price,
        this.image,
        this.isFavorite,
        this.onTap,
        this.leftBtnName,
        this.rightBtnName,
        this.isBookMarkNeed,
        this.progressStatus, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index ?? 0,
      columnCount: 2,
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50,
        child: SlideAnimation(
          delay: Duration(milliseconds: 275),
          child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 0), // shadow in all directions
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section

                      CustomNetworkImage(

                          borderRadius: BorderRadius.circular(8.r),
                          imageUrl: "$image",
                          height: 120.h,
                          width: 102.w),

                      SizedBox(width: 7.w),

                      // Info Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      maxline: 1,
                                      text: "$title",
                                      fontWeight: FontWeight.w600,
                                      bottom: 4.h,
                                      color: Colors.black),
                                ),
                                if (isBookMarkNeed ?? false)
                                  isFavorite ?? false
                                      ? Icon(Icons.favorite,
                                      color: AppColors.primaryColor)
                                      : Icon(Icons.favorite_border, color: AppColors.primaryColor)
                              ],
                            ),
                            SizedBox(width: 4.w),
                            CustomText(
                                text: "Price: 30\$",
                                fontWeight: FontWeight.w500),
                            CustomText(
                                maxline: 3,
                                text:
                                "Transform your look with expert cuts, styling, and personalized service at our premier salon, designed for your ultimate satisfaction.",
                                fontSize: 10.h,
                                textAlign: TextAlign.start,
                                bottom: 4.h,
                                color: Colors.black),
                            SizedBox(height: 10.h),
                            progressStatus?.isNotEmpty ?? false ?

                            progressStatus?.toLowerCase() == "received" ?
                            CustomButton(
                                width: 120.w,
                                height: 26.h,
                                loaderIgnore: true,
                                fontSize: 10.h,
                                title: "$progressStatus", onpress: () {



                              TextEditingController amonCtrl =
                              TextEditingController();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                            text: "Give Feedback",
                                            fontSize: 22.h,
                                            fontWeight: FontWeight.w600,
                                            top: 29.h,
                                            bottom: 20.h),


                                        Align(
                                          alignment: Alignment.center,
                                          child: RatingBar.builder(
                                            initialRating: 3,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemSize: 28,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),

                                        SizedBox(height: 12.h),
                                        CustomTextField(
                                            minLines: 3,
                                            filColor: Colors.white,
                                            borderColor: AppColors.primaryColor,
                                            showShadow: false,
                                            labelText: "Add Comments",
                                            controller: amonCtrl,
                                            hintText: "Write here"),


                                        SizedBox(height: 20.h),


                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: CustomButton(
                                                  height: 50.h,
                                                  title: "Submit",
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
                                                  title: "Cancel",
                                                  onpress: () {
                                                    Navigator.pop(context);
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




                            }) :

                            Row(
                              children: [

                                if(isHistory)
                                  Container(
                                    margin: EdgeInsets.only(right: 12.w),
                                    height: 14.h,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: progressStatus?.toLowerCase() == "cancel" ? Colors.red : AppColors.primaryColor
                                    ),
                                  ),

                                CustomText(
                                    text: "$progressStatus",
                                    color: progressStatus?.toLowerCase() == "cancel" ? Colors.red : AppColors.primaryColor),
                              ],
                            )

                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}