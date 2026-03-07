import 'package:danceattix/models/notification_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  /// <======================= products ===========================>

  bool isLoading = false;
  bool isLoadingMore = false;
  int limit = 10;
  int page = 1;
  int totalPage = -1;
  int totalNotification = 0;
  List<NotificationModelData> notificationData = [];


  Future<void> notificationGet({
    bool isInitialLoad = true,
  }) async {
    if (isInitialLoad) {
      notificationData.clear();
      page = 1;
      totalPage = -1;
      isLoading = true;
      isLoadingMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.notification(
        page: page,
        limit: limit,
      ),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];

      final product = data.map((json) => NotificationModelData.fromJson(json)).toList();

      notificationData.addAll(product);
      totalPage = responseBody['pagination']?['totalPages'] ?? totalPage;
    } else {
      showToast(responseBody['message']);
    }

    isLoading = false;
    isLoadingMore = false;
    update();
  }

  void notificationMore() async {
    debugPrint('============> Page $page');

    if (page < totalPage && !isLoadingMore) {
      page += 1;
      isLoadingMore = true;
      update();

      await notificationGet(isInitialLoad: false);
      debugPrint(
        '============> Page++ $page \n=============> totalPage $totalPage',
      );
    }
  }
}
