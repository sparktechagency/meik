import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notifications"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(6.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            offset: Offset(-1, 2)
                          )
                        ]
                      ),
                      padding: EdgeInsets.all(12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Color(0xffE7E7E7),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.notifications_outlined)),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.w,
                                child: CustomText(
                                    maxline: 3,
                                    textAlign: TextAlign.start,
                                    color: Colors.black,
                                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                                    fontSize: 12.h),
                              ),


                              CustomText(
                                  text: "11:58 PM", fontSize: 9.h),
                            ],
                          ),


                        ],
                      ),
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
