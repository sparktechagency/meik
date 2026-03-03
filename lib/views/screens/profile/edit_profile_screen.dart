import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/helper/photo_picker_helper.dart';
import 'package:danceattix/views/widgets/custom_image_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    _userController.firstNameCtrl.text = _userController.userData?.firstName ?? '';
    _userController.lastNameCtrl.text = _userController.userData?.lastName ?? '';
    _userController.addressCtrl.text = _userController.userData?.address ?? '';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: "Profile Information"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 70.h),

            GetBuilder<UserController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    // Handle profile picture change
                    PhotoPickerHelper.showPicker(context: context, onImagePicked: (image) => controller.onImagePicked(image));
                  },
                  child: Stack(
                    children: [
                      CustomImageAvatar(
                        showBorder: true,
                        radius: 54.r,
                        image: controller.userData?.image ?? '',
                        fileImage: controller.profileImage,
                      ),

                      Positioned(
                        bottom: 7.h,
                          left: 0,
                          right: 0,
                          child: Icon(Icons.camera_alt_outlined, color: Colors.white)

                      )
                    ],
                  ),
                );
              }
            ),


            SizedBox(height: 16.h),


            CustomTextField(
              shadowNeed: false,
              controller: _userController.firstNameCtrl,
              labelText: "Your First Name",
              hintText: "your first name",
              contentPaddingVertical: 10.h,
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
            ),

            CustomTextField(
              shadowNeed: false,
              controller: _userController.lastNameCtrl,
              labelText: "Your Last Name",
              hintText: "your last name",
              contentPaddingVertical: 10.h,
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
            ),


            CustomTextField(
              shadowNeed: false,
              controller: _userController.addressCtrl,
              hintText: "your address",
              labelText: "Address",
              borderColor: Color(0xff592B00),
              hintextColor: Colors.black,
              contentPaddingVertical: 10.h,
            ),



            Spacer(),


            GetBuilder<UserController>(
              builder: (controller) {
                return controller.isLoadingUserUpdate ? CustomLoader() : CustomButton(title: "Update Profile", onpress: (){
                controller.userUpdate();
                });
              }
            ),

            SizedBox(height: 100.h)


          ],
        ),
      ),
    );
  }
}
