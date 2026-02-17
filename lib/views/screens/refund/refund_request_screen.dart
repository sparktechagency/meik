import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class RefundRequestScreen extends StatefulWidget {
  RefundRequestScreen({super.key});

  @override
  State<RefundRequestScreen> createState() => _RefundRequestScreenState();
}

class _RefundRequestScreenState extends State<RefundRequestScreen> {
  TextEditingController reasonCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Request Refund"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xfffef4ea), // Card background
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 0), // shadow in all directions
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section

                    CustomNetworkImage(
                        borderRadius: BorderRadius.circular(8.r),
                        imageUrl:
                            "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                        height: 139.h,
                        width: 109.w),

                    SizedBox(width: 7.w),

                    // Info Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                  text: "Cat Travel Bag (Used)",
                                  fontWeight: FontWeight.w600,
                                  bottom: 4.h,
                                  color: Colors.black),
                            ],
                          ),
                          Row(
                            children: [
                              Assets.icons.moneyIconCard.svg(),
                              SizedBox(width: 4.w),
                              CustomText(
                                text: "30\$",
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          CustomText(
                            text: "Location: Banani, Dhaka",
                            fontSize: 12.h,
                            color: Colors.black,
                            bottom: 7.h,
                          ),
                          CustomText(
                            text: "Date of purchase: 12 june",
                            fontSize: 12.h,
                            bottom: 4.h,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: "Sarah Rahman",
                            fontSize: 12.h,
                            bottom: 4.h,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: "⭐ 4.8 | Verified Seller",
                            fontSize: 12.h,
                            bottom: 4.h,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            CustomText(
                text: "Upload Images",
                color: Colors.black,
                fontSize: 16.h,
                top: 8.h,
                bottom: 10.h),


            GestureDetector(
              onTap: _pickImages,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xfffef4ea),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    child: Assets.icons.arrowTop.svg(),
                  ),
                ),
              ),
            ),


            if (_images.isNotEmpty)
              Padding(
                padding:  EdgeInsets.only(top: 12.h),
                child: SizedBox(
                  height: 60.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: 60.h,
                              height: 60.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.file(
                                  _images[index],
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),


            SizedBox(height: 12.h),

            CustomTextField(
              controller: reasonCtrl,
              hintText: "Select a Reason",
              labelText: "Why do you want a refund?",
              suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
            ),



            CustomTextField(
              controller: descriptionCtrl,
              hintText: "Description",
              labelText: "Description"
            ),


            Spacer(),

            CustomButton(title: "Submit", onpress: () {

            }),


            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  List<File> _images = [];

  int _currentIndex = 0;

  Future<void> _pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null) {
      final newImages = picked.map((x) => File(x.path)).toList();
      setState(() {
        final remaining = 5 - _images.length;
        _images.addAll(newImages.take(remaining));
        _currentIndex = _images.length - 1;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_images.isNotEmpty) {
        _currentIndex = index > 0 ? index - 1 : 0;
      } else {
        _currentIndex = 0;
      }
    });
  }
}
