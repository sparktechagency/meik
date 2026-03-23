import 'dart:io';
import 'package:danceattix/controllers/fvrt_product_controller.dart';
import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/core/app_constants/app_constants.dart';
import 'package:danceattix/core/config/app_route.dart';
import 'package:danceattix/helper/prefs_helper.dart';
import 'package:danceattix/models/user_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    userGet();
  }


  /// <======================= user get ===========================>
  bool isLoadingUser = false;
  UserModelData? userData;



  Future<void> userGet() async {
    isLoadingUser = true;
    update();

    final response = await ApiClient.getData(ApiUrls.userMe);
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final user = responseBody['data'];
      userData = UserModelData.fromJson(user);

    } else {
      //showToast(responseBody['message']);
    }

    isLoadingUser = false;
    update();
  }


  /// <======================= user update ===========================>
  bool isLoadingUserUpdate = false;
  File? profileImage;
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();


  void onImagePicked(XFile image) {
    profileImage = File(image.path);
    update();
  }

  Future<void> userUpdate() async {
    isLoadingUserUpdate = true;
    update();


    final requestBody = {
      "firstName": firstNameCtrl.text.trim(),
      "lastName": lastNameCtrl.text.trim(),
      "address": addressCtrl.text.trim(),
    };

    List<MultipartBody> multipartBodies = [];
    if (profileImage != null) {
      multipartBodies.add(MultipartBody('image', profileImage!,));
    }

    final response = await ApiClient.patchMultipartData(ApiUrls.userUpdate,requestBody,multipartBody: multipartBodies);
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final user = responseBody['data'];
      userData = UserModelData.fromJson(user);
    //  showToast(responseBody['message']);
      profileImage = null;
      Get.back();

    } else {
     // showToast(responseBody['message']);
    }

    isLoadingUserUpdate = false;
    update();
  }




  void userLogout() async {
    PrefsHelper.remove(AppConstants.bearerToken);
    SocketServices.instance.disconnect();
    Get.find<UserController>().userData = null;
    Get.find<FvrtProductController>().fvrtData.clear();
    Get.find<FvrtProductController>().purchasesData.clear();
    Get.find<FvrtProductController>().salesData.clear();
    Get.find<ProductController>().listedProductsData.clear();
    Get.find<ProductController>().pendingProductsData.clear();
    Get.offAllNamed(AppRoutes.logInScreen);

  }

}
