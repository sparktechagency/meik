
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/core/config/app_route.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final RxString selectedLang = 'ru'.obs;

  @override
  Widget build(BuildContext context) {
    selectedLang.value = TranslationService().currentLanguage ?? 'en';

    return Scaffold(
      appBar: CustomAppBar(title: 'Languages'),

      body: Obx(() => ListView(
        children: [
          _buildLanguageTile(
            context,
            flag: '🇷🇺',
            name: 'Russian',
            code: 'ru',
          ),

          _buildLanguageTile(
            context,
            flag: '🇰🇿',
            name: 'Kazakh',
            code: 'kk',
          ),

          _buildLanguageTile(
            context,
            flag: '🇺🇸',
            name: 'English',
            code: 'en',
          ),
        ],
      )),
    );
  }

  Widget _buildLanguageTile(
      BuildContext context, {
        required String flag,
        required String name,
        required String code,
      }) {
    return ListTile(
      selectedColor: AppColors.primaryShade100,
      leading: Text(
        flag,
        style: TextStyle(fontSize: 22.sp),
      ),
      title: Text(name),

      // ✅ Radio button style suffix
      trailing: Radio<String>(
        value: code,
        groupValue: selectedLang.value,
        onChanged: (value) async {
          selectedLang.value = value!;
          await TranslationService().setLanguage(value);
          Get.offAllNamed(AppRoutes.bottomNavBar);
        },
        activeColor: AppColors.primaryColor,
      ),

      onTap: () async {
        selectedLang.value = code;
        await TranslationService().setLanguage(code);
        Get.offAllNamed(AppRoutes.bottomNavBar);
      },
    );
  }
}
