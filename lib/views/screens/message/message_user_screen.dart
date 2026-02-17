import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class MessageUserScreen extends StatefulWidget {
  const MessageUserScreen({super.key});

  @override
  State<MessageUserScreen> createState() => _MessageUserScreenState();
}

class _MessageUserScreenState extends State<MessageUserScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Messages"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
                controller: searchCtrl,
                hintextColor: Colors.black87,
                hintText: "Search by products name",
                suffixIcon: Assets.icons.searhIcon.svg()),




            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: () {
                       Get.toNamed(AppRoutes.messageScreen);
                     },
                     child: Container(
                        margin: EdgeInsets.all(3.r),
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              border:
                                  Border.all(color: Color(0xff592B00), width: 0.002),
                              imageUrl: "https://i.pravatar.cc/150?img=3",
                              height: 58.h,
                              width: 58.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "T-Shirt",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    bottom: 6.h),
                                CustomText(
                                    text: "hello how are you", fontSize: 12.h),
                              ],
                            ),
                            Spacer(),
                            CustomText(
                                text: "4:15 PM"),
                            SizedBox(width: 8.w)
                          ],
                        ),
                      ),
                   );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
