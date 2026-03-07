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

    final response = await ApiClient.getData(ApiUrls.productDetails(productID));
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final data = responseBody['data'];
      productDetailsData = ProductDetailsModelData.fromJson(data);
    } else {
      showToast(responseBody['message']);
    }

    isLoadingDetails = false;
    update();
  }

  /// <======================= favourite ===========================>
  bool isLoadingFvrt = false;

  Future<void> toggleFavourite(int productId) async {
    if (productDetailsData == null) return;

    // Optimistic UI update
    productDetailsData!.isFavorite = !(productDetailsData!.isFavorite ?? false);
    update();

    isLoadingFvrt = true;

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

    isLoadingFvrt = false;
    update();
  }

  /// <======================= seller products ===========================>

  bool isLoadingProduct = false;
  bool isLoadingProductMore = false;
  int productLimit = 10;
  int productPage = 1;
  int productTotalPage = -1;
  int totalProduct = 0;
  List<ProductModelData> fvrtProductsData = [];

  Future<void> fvrtProductsGet({
    String type = '',
    bool isInitialLoad = true,
  }) async {
    if (isInitialLoad) {
      fvrtProductsData.clear();
      productPage = 1;
      productTotalPage = -1;
      isLoadingProduct = true;
      isLoadingProductMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.fvrtProduct(page: productPage, limit: productLimit),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];
      final product = data
          .map((json) => ProductModelData.fromJson(json))
          .toList();

      fvrtProductsData.addAll(product);
      productTotalPage =
          responseBody['pagination']?['totalPages'] ?? productTotalPage;
      totalProduct = responseBody['pagination']?['total'] ?? totalProduct;
    } else {
      showToast(responseBody['message']);
    }

    isLoadingProduct = false;
    isLoadingProductMore = false;
    update();
  }

  void productsMore(String type) async {
    debugPrint('============> Page $productPage');
    if (productPage < productTotalPage && !isLoadingProductMore) {
      productPage += 1;
      isLoadingProductMore = true;
      update();
      await fvrtProductsGet(type: type, isInitialLoad: false);
      debugPrint(
        '============> Page++ $productPage \n=============> totalPage $productTotalPage',
      );
    }
  }
}