import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/config/app_route.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ProfileInformationScreen extends StatelessWidget {
  ProfileInformationScreen({super.key});

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile Information"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 26.h),

            CustomNetworkImage(
              imageUrl: "https://i.pravatar.cc/150?img=3",
              height: 85.h,
              width: 85.w,
              boxShape: BoxShape.circle,
            ),


            SizedBox(height: 16.h),


            CustomTextField(
              shadowNeed: false,
              readOnly: true,
              controller: nameCtrl,
              hintText: "victor",
              labelText: "Your Name",
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
              contentPaddingVertical: 10.h,
            ),


            CustomTextField(
              shadowNeed: false,
              readOnly: true,
              controller: emailCtrl,
              hintText: "sagorahammed@gmail.com",
              labelText: "E-mail",
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
              contentPaddingVertical: 10.h,
            ),



            CustomTextField(
              shadowNeed: false,
              readOnly: true,
              controller: phoneCtrl,
              hintText: "54123545121",
              labelText: "Phone No.",
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
              contentPaddingVertical: 10.h,
            ),



            CustomTextField(
              shadowNeed: false,
              readOnly: true,
              controller: addressCtrl,
              hintText: "USA, New york, post code-5212",
              labelText: "Address",
              hintextColor: Colors.black,
              borderColor: Color(0xff592B00),
              contentPaddingVertical: 10.h,
            ),



            Spacer(),


            CustomButton(title: "Edit Profile", onpress: (){
              Get.toNamed(AppRoutes.editProfileScreen);
            }),

            SizedBox(height: 100.h)


          ],
        ),
      ),
    );
  }
}
