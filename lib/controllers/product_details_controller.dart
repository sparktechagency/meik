import 'package:danceattix/models/product_details_model_data.dart';
import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {





  /// <======================= details ===========================>
  bool isLoadingDetails = false;
  ProductDetailsModelData? productDetailsData;

  Future<void> productDetails(int productID) async {
    isLoadingDetails = true;
    update();

    try {
      final response = await ApiClient.getData(ApiUrls.productDetails(productID));
      final responseBody = response.body;

      if (response.statusCode == 200) {
        final data = responseBody['data'];
        productDetailsData = ProductDetailsModelData.fromJson(data);
      } else {
        //showToast(responseBody['message'] ?? 'Failed to load product details');
      }
    } catch (e) {
      debugPrint('productDetails error: $e');
    } finally {
      isLoadingDetails = false;
      update();
    }
  }

  /// <======================= favourite ===========================>
  bool isLoadingFvrt = false;

  Future<void> toggleFavourite(int productId) async {
    if (productDetailsData == null) return;

    // Optimistic UI update
    productDetailsData!.isFavorite = !(productDetailsData!.isFavorite ?? false);
    update();

    isLoadingFvrt = true;

    try {
      final requestBody = {"productId": productId};
      final response = await ApiClient.postData(ApiUrls.favourites, requestBody);
      final responseBody = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        // success — optimistic update already applied
      } else {
        // Revert on failure
        productDetailsData!.isFavorite = !(productDetailsData!.isFavorite ?? false);
        showToast(responseBody['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      // Revert on exception
      productDetailsData!.isFavorite = !(productDetailsData!.isFavorite ?? false);
      debugPrint('toggleFavourite error: $e');
      showToast('Something went wrong');
    } finally {
      isLoadingFvrt = false;
      update();
    }
  }

}