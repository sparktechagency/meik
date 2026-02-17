import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "All History"),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [

            SizedBox(height: 16.h),


            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3.r),
                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        CustomNetworkImage(
                          border: Border.all(color: Color(0xff592B00), width: 3),
                          imageUrl: "https://i.pravatar.cc/150?img=3",
                          height: 58.h,
                          width: 58.w,
                          boxShape: BoxShape.circle,
                        ),



                        SizedBox(width: 10.w),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomText(text: "Jeorge Mayank", fontWeight: FontWeight.w500, bottom: 6.h),

                            CustomText(text: "Transition id: 4524214212", fontSize: 12.h),
                            CustomText(text: "21 April 2025", fontSize: 12.h),

                          ],
                        ),


                        Spacer(),

                        CustomText(text: "\$ 25", fontSize: 28.h, color: Colors.black),

                        SizedBox(width: 8.w)


                      ],
                    ),
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
