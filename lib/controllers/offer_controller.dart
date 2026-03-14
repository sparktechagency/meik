import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  /// <======================= Offer send ===========================>
  bool isLoadingSend = false;

  Future<void> send(int productID, double price) async {
    isLoadingSend = true;
    update();

    try {
      final response = await ApiClient.postData(ApiUrls.offersSend, {
        "product_id": productID,
        "price": price,
      });
      if (response.statusCode == 201) {
        showToast(response.body['message']);
        await Future.delayed(const Duration(milliseconds: 300));
        Get.back();
      } else {
        showToast(response.body['message']);
        await Future.delayed(const Duration(milliseconds: 300));
        Get.back();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingSend = false;
      update();
    }
  }

  /// <======================= Offer accept ===========================>
  bool isLoadingAccept = false;

  Future<void> accept(String offerID) async {
    isLoadingAccept = true;
    update();

    try {
      final response = await ApiClient.postData(
        ApiUrls.offersAccept(offerID),
        {},
      );
      if (response.statusCode == 201) {
      } else {
        showToast(response.body['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingAccept = false;
      update();
    }
  }

  /// <======================= Offer reject ===========================>
  bool isLoadingReject = false;

  Future<void> reject(String offerID) async {
    isLoadingReject = true;
    update();

    try {
      final response = await ApiClient.postData(
        ApiUrls.offersReject(offerID),
        {},
      );
      if (response.statusCode == 200) {
      } else {
        showToast(response.body['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingReject = false;
      update();
    }
  }
}
