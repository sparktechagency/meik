import 'package:danceattix/controllers/product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/views/screens/drawer/widgets/price_range_widget.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 320.w,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Assets.icons.clean.svg(width: 24.w, height: 24.h),
                  ),
                  Spacer(),
                  CustomText(
                    text: "Filter",
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                  Spacer(),
                ],
              ),
            ),

            // Filter Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.r),
                child: GetBuilder<ProductController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price Range
                        CustomText(
                          text: 'Price Range',
                          fontSize: 16.sp,
                          bottom: 16.h,
                        ),

                        RangeSliderScreen(
                          onRangeChanged: (range) {
                            controller.priceLimit =
                                '${range.start.toInt()}-${range.end.toInt()}';
                            controller.update();
                          },
                        ),
                        SizedBox(height: 20.h),

                        // Products condition
                        _buildFilterSection(
                          "Products condition",
                          controller.conditions,
                          controller.selectedCondition,
                          (val) {
                            controller.selectedCondition = val;
                            controller.update();

                          },
                        ),

                        // Products for
                        _buildFilterSection(
                          "Products for",
                          controller.productFor,
                          controller.selectedProductFor,
                          (val) {
                            controller.selectedProductFor = val;
                            controller.update();

                          },
                        ),

                        // Brand
                        _buildFilterSection(
                          "Brand",
                          controller.brands,
                          controller.selectedBrand,
                          (val) {
                            controller.selectedBrand = val;
                            controller.update();

                          },
                        ),

                        // Products category
                        _buildFilterSection(
                          "Products category",
                          controller.categories,
                          controller.selectedCategory,
                          (val) {
                            controller.selectedCategory = val;
                            controller.update();

                          },
                        ),

                        // Size
                        _buildFilterSection(
                          "Size",
                          controller.sizes,
                          controller.selectedSizes,
                          (val) {
                            controller.selectedSizes = val;
                            controller.update();

                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Apply Button
            Padding(
              padding: EdgeInsets.all(20.r),
              child: GetBuilder<ProductController>(
                builder: (controller) {
                  return CustomButton(
                    title: "Buy now",
                    onpress: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.productsGet();
                      });
                      Navigator.pop(context);
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String selected,
    Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 16.sp, color: Colors.black),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((option) {
            final isSelected = selected == option;
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
                child: CustomText(
                  text: option,
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
