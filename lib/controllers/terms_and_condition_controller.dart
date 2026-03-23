import 'package:get/get.dart';
import '../services/api_client.dart';
import '../services/api_urls.dart';

class TermsAndConditionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString content = ''.obs;
  final RxString errorMessage = ''.obs;

  Future<void> fetchTermsAndCondition() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ApiClient.getData(ApiUrls.termsAndCondition);

      if (response.statusCode == 200) {
        if (response.body != null && response.body is Map) {
          content.value = response.body['data']?['content'] ?? 
                         response.body['content'] ?? 
                         response.body['data']?.toString() ?? 
                         response.body.toString();
          errorMessage.value = '';
        } else {
          content.value = response.bodyString ?? '';
        }
      } else {
        errorMessage.value = response.statusText ?? 'Failed to load terms and conditions';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
