import 'package:danceattix/models/conversations_model_data.dart';
import 'package:danceattix/models/inbox_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
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

  Future<void> conversationGet({bool isInitialLoad = true,term = ''}) async {
    if (isInitialLoad) {
      conversationsData.clear();
      conPage = 1;
      conTotalPage = -1;
      isLoadingCon = true;
      isLoadingConMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.conversations(page: conPage, limit: conLimit,term: term),
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

  /// <======================= conversations get by id ===========================>
  bool isLoadingInbox = false;
  bool isLoadingInboxMore = false;

  int inboxPage = 1;
  int inboxLimit = 100;
  int inboxTotalPage = -1;
  InboxModelData? inboxData;

  Future<void> inboxGet({String conID = '', bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      inboxData = null;
      inboxPage = 1;
      inboxTotalPage = -1;
      isLoadingInbox = true;
      isLoadingInboxMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.inbox(conID: conID, page: inboxPage, limit: inboxLimit),
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final data = responseBody['data'] ?? {};

      inboxData = InboxModelData.fromJson(data);

      inboxTotalPage = responseBody['pagination']?['totalPages'] ?? inboxTotalPage;
    } else {
      //showToast(responseBody['message']);
    }

    isLoadingInbox = false;
    isLoadingInboxMore = false;
    update();
  }

  void inboxMore() async {
    debugPrint('============> Page $inboxPage');

    if (inboxPage < inboxTotalPage && !isLoadingInboxMore) {
      inboxPage += 1;
      isLoadingInboxMore = true;
      update();

      await inboxGet(isInitialLoad: false);
      debugPrint(
        '============> Page++ $inboxPage \n=============> totalPage $inboxTotalPage',
      );
    }
  }
}
