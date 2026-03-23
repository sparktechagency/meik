import 'package:danceattix/models/favourite_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FvrtProductController extends GetxController {
  /// <======================= Favourite ===========================>

  bool isLoading = false;
  bool isLoadingMore = false;
  int limit = 10;
  int page = 1;
  int totalPage = -1;
  List<FavouriteModelData> fvrtData = [];

  Future<void> fvrtGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      fvrtData.clear();
      page = 1;
      totalPage = -1;
      isLoading = true;
      isLoadingMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.fvrtProduct(page: page, limit: limit),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];
      fvrtData.addAll(data.map((json) => FavouriteModelData.fromJson(json)).toList());
      totalPage = responseBody['pagination']?['totalPages'] ?? totalPage;
    } else {
      showToast(responseBody['message']);
    }

    isLoading = false;
    isLoadingMore = false;
    update();
  }

  void fvrtMore() async {
    if (page < totalPage && !isLoadingMore) {
      page += 1;
      isLoadingMore = true;
      update();
      await fvrtGet(isInitialLoad: false);
    }
  }

  /// <======================= Purchases ===========================>

  bool isPurchasesLoading = false;
  bool isPurchasesLoadingMore = false;
  int purchasesPage = 1;
  int purchasesTotalPage = -1;
  List<SalesModelData> purchasesData = [];

  Future<void> phurcasesGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      purchasesData.clear();
      purchasesPage = 1;
      purchasesTotalPage = -1;
      isPurchasesLoading = true;
      isPurchasesLoadingMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.phurcasesProduct(page: purchasesPage, limit: limit),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];
      purchasesData.addAll(data.map((json) => SalesModelData.fromJson(json)).toList());
      purchasesTotalPage = responseBody['pagination']?['totalPages'] ?? purchasesTotalPage;
    } else {
      showToast(responseBody['message']);
    }

    isPurchasesLoading = false;
    isPurchasesLoadingMore = false;
    update();
  }

  void phurcasesMore() async {
    if (purchasesPage < purchasesTotalPage && !isPurchasesLoadingMore) {
      purchasesPage += 1;
      isPurchasesLoadingMore = true;
      update();
      await phurcasesGet(isInitialLoad: false);
    }
  }

  /// <======================= Sales ===========================>

  bool isSalesLoading = false;
  bool isSalesLoadingMore = false;
  int salesPage = 1;
  int salesTotalPage = -1;
  List<SalesModelData> salesData = [];

  Future<void> salesGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      salesData.clear();
      salesPage = 1;
      salesTotalPage = -1;
      isSalesLoading = true;
      isSalesLoadingMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.salesProduct(page: salesPage, limit: limit),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];
      salesData.addAll(data.map((json) => SalesModelData.fromJson(json)).toList());
      salesTotalPage = responseBody['pagination']?['totalPages'] ?? salesTotalPage;
    } else {
      showToast(responseBody['message']);
    }

    isSalesLoading = false;
    isSalesLoadingMore = false;
    update();
  }

  void salesMore() async {
    if (salesPage < salesTotalPage && !isSalesLoadingMore) {
      salesPage += 1;
      isSalesLoadingMore = true;
      update();
      await salesGet(isInitialLoad: false);
    }
  }
}