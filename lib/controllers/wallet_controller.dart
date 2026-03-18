import 'package:danceattix/models/favourite_model_data.dart';
import 'package:danceattix/models/transaction_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    balanceGet();
  }

  /// <======================= balance ===========================>

  bool isLoading = false;
  String balance = '';

  Future<void> balanceGet() async {
    isLoading = true;
    update();

    try {
      final response = await ApiClient.getData(ApiUrls.balance);
      final responseBody = response.body;

      if (response.statusCode == 200) {
        balance = responseBody['data']['balance'].toStringAsFixed(2);
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast('Something went wrong. Please try again.');
    } finally {
      isLoading = false;
      update();
    }
  }

  /// <======================= Transaction ===========================>

  bool isTransactionLoading = false;
  bool isTransactionLoadingMore = false;
  int transactionPage = 1;
  int limit = 10;
  int transactionTotalPage = -1;
  List<TransactionModelData> transactions = [];

  Future<void> transactionGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      transactions.clear();
      transactionPage = 1;
      transactionTotalPage = -1;
      isTransactionLoading = true;
      isTransactionLoadingMore = false;
      update();
    }

    try {
      final response = await ApiClient.getData(
        ApiUrls.transections(page: transactionPage, limit: limit),
      );
      final responseBody = response.body;

      if (response.statusCode == 200) {
        final List data = responseBody['data'] ?? [];
        transactions.addAll(
          data.map((json) => TransactionModelData.fromJson(json)).toList(),
        );
        transactionTotalPage =
            responseBody['pagination']?['totalPages'] ?? transactionTotalPage;
      } else {
        showToast(responseBody['message']);
      }
    } catch (e) {
      showToast('Something went wrong. Please try again.');
    } finally {
      isTransactionLoading = false;
      isTransactionLoadingMore = false;
      update();
    }
  }

  void transactionMore() async {
    if (transactionPage < transactionTotalPage && !isTransactionLoadingMore) {
      transactionPage += 1;
      isTransactionLoadingMore = true;
      update();
      await transactionGet(isInitialLoad: false);
    }
  }
}