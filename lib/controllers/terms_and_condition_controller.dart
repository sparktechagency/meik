import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_client.dart';
import '../services/api_urls.dart';

enum ContentType { termsAndCondition, privacyPolicy, aboutUs }

class TermsAndConditionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString content = ''.obs;

  Future<void> fetchContent(ContentType type) async {
    try {
      isLoading.value = true;

      String endpoint;
      switch (type) {
        case ContentType.termsAndCondition:
          endpoint = ApiUrls.termsAndCondition;
          break;
        case ContentType.privacyPolicy:
          endpoint = ApiUrls.privacyPolicy;
          break;
        case ContentType.aboutUs:
          endpoint = ApiUrls.aboutUs;
          break;
      }

      final response = await ApiClient.getData(endpoint);

      if (response.statusCode == 200) {
        content.value = response.body['content'] ?? '';
      } else {
        content.value = '';
      }
    } catch (e) {
      debugPrint('Error fetching content: $e');
      content.value = '';
    } finally {
      isLoading.value = false;
    }
  }
}

