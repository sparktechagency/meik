import 'package:danceattix/models/boost_pricing_mode_data.dart';
import 'package:danceattix/models/notification_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostController extends GetxController {

  /// Loading state for boost action
  bool isLoading = false;

  /// Boost a product with specified days
  Future<void> boost(int productID, int days) async {
    isLoading = true;
    update();

    try {
      final response = await ApiClient.put(
        ApiUrls.boost(productID, days),
        {},
      );

      final responseBody = response.body;

      if (response.statusCode == 200) {
        showToast(responseBody['message'] ?? 'Post boosted successfully!');
        // Clear selected pricing after successful boost
        selectedPricingIndex = null;
        boostPricingData.clear();

        Get.back(); // Close the dialog
      } else {
        showToast(
          responseBody['message'] ?? 'Failed to boost post. Please try again.',
        );
      }
    } catch (e) {
      showToast('Error: ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Pricing list management
  bool isLoadingPrices = false;
  bool isLoadingMore = false;
  int limit = 10;
  int page = 1;
  int totalPage = -1;
  int totalNotification = 0;
  int? selectedPricingIndex; // Track selected pricing option
  List<BoostPricingModelData> boostPricingData = [];

  /// Fetch boost pricing options
  Future<void> boostPricingGet({
    bool isInitialLoad = true,
    String productID = '',
  }) async {
    if (isInitialLoad) {
      boostPricingData.clear();
      selectedPricingIndex = null; // Reset selection when fetching new data
      page = 1;
      totalPage = -1;
      isLoadingPrices = true;
      isLoadingMore = false;
      update();
    }

    try {
      final response = await ApiClient.getData(
        ApiUrls.boostPricing(productID),
      );

      final responseBody = response.body;

      if (response.statusCode == 200) {
        final List data = responseBody['data']['pricing'] ?? [];

        final pricingList = data
            .map((json) => BoostPricingModelData.fromJson(json))
            .toList();

        boostPricingData.addAll(pricingList);
        totalPage = responseBody['pagination']?['totalPages'] ?? totalPage;

        if (boostPricingData.isEmpty) {
          showToast('No pricing options available');
        }
      } else {
        showToast(
          responseBody['message'] ?? 'Failed to load pricing options',
        );
      }
    } catch (e) {
      showToast('Error: ${e.toString()}');
    } finally {
      isLoadingPrices = false;
      isLoadingMore = false;
      update();
    }
  }

  /// Set selected pricing option
  void setSelectedPricing(int index) {
    selectedPricingIndex = index;
    update();
  }

  /// Clear selected pricing
  void clearSelectedPricing() {
    selectedPricingIndex = null;
    update();
  }

  /// Load more pricing options (pagination)
  void loadMorePricing() async {
    debugPrint('============> Current Page: $page');

    if (page < totalPage && !isLoadingMore) {
      page += 1;
      isLoadingMore = true;
      update();

      await boostPricingGet(isInitialLoad: false);
      debugPrint(
        '============> Updated Page: $page \n=============> Total Pages: $totalPage',
      );
    }
  }

  @override
  void onClose() {
    // Clean up resources
    selectedPricingIndex = null;
    boostPricingData.clear();
    super.onClose();
  }
}