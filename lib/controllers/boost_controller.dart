import 'package:danceattix/models/notification_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostController extends GetxController {

  bool isLoading = false;

  Future<void> boost(int productID) async {

      isLoading = true;
      update();

    final response = await ApiClient.put(ApiUrls.boost(productID),{});

    final responseBody = response.body;

    if (response.statusCode == 200) {
      Get.back();
      showToast(responseBody['message']);
    } else {
      showToast(responseBody['message']);
    }

    isLoading = false;
    update();
  }

}
