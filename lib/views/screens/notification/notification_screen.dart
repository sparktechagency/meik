import 'package:danceattix/controllers/notification_controller.dart';
import 'package:danceattix/helper/time_format_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final NotificationController _controller = Get.find<NotificationController>();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _controller.notificationGet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColorWhite,
      appBar: CustomAppBar(title: "Notifications"),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: ()  async{
            await  _controller.notificationGet();

            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16.h),
              itemCount: controller.notificationData.length,
              itemBuilder: (context, index) {
                final data = controller.notificationData[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical:  6.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      boxShadow: [
                        if(data.isRead == true)
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 16,
                          offset: Offset(0, 4)
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
                            child: Icon(Icons.notifications_outlined,color: Colors.grey,)),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  maxline: 1,
                                  fontWeight: data.isRead == true ? FontWeight.w600 : FontWeight.w400,
                                  textAlign: TextAlign.start,
                                  color: Colors.black,
                                  text: data.related ?? 'N/A',
                                  fontSize: 12.h),

                              CustomText(
                                top: 6.h,
                                  maxline: 2,
                                  fontWeight: data.isRead == true ? FontWeight.w600 : FontWeight.w400,
                                  textAlign: TextAlign.start,
                                  color: Colors.black,
                                  text: data.msg ?? 'N/A',
                                  fontSize: 10.h),


                              CustomText(
                                  text: TimeFormatHelper.timeFormat(DateTime.parse(data.createdAt ?? '')), fontSize: 10.h),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
