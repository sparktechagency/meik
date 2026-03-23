import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/terms_and_condition_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';


class PrivacyPolicyAllScreen extends StatelessWidget {
  const PrivacyPolicyAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsAndConditionController());
    final title = Get.arguments?['title'] ?? 'Terms and Conditions';
    
    controller.fetchTermsAndCondition();

    return Scaffold(
      appBar: CustomAppBar(title: title),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    color: Colors.red,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () => controller.fetchTermsAndCondition(),
                    icon: Icon(Icons.refresh),
                    label: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                CustomText(
                  color: Colors.black,
                  maxline: 1000,
                  textAlign: TextAlign.start,
                  text: controller.content.value,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
