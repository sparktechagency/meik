import 'package:danceattix/models/conversations_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    conversationGet();
  }

  /// <======================= conversations get ===========================>
  bool isLoadingCon = false;
  bool isLoadingConMore = false;

  int conPage = 1;
  int conLimit = 50;
  int conTotalPage = -1;
  List<ConversationsModelData> conversationsData = [];

  Future<void> conversationGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      conversationsData.clear();
      conPage = 1;
      conTotalPage = -1;
      isLoadingCon = true;
      isLoadingConMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.conversations(page: conPage, limit: conLimit),
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];

      final conversations = data
          .map((json) => ConversationsModelData.fromJson(json))
          .toList();

      conversationsData.addAll(conversations);

      conTotalPage = responseBody['pagination']?['totalPages'] ?? conTotalPage;
    } else {
      //showToast(responseBody['message']);
    }

    isLoadingCon = false;
    isLoadingConMore = false;
    update();
  }

  void conversationMore() async {
    debugPrint('============> Page $conPage');

    if (conPage < conTotalPage && !isLoadingConMore) {
      conPage += 1;
      isLoadingConMore = true;
      update();

      await conversationGet(isInitialLoad: false);
      debugPrint(
        '============> Page++ $conPage \n=============> totalPage $conTotalPage',
      );
    }
  }
}
