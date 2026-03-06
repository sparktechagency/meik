import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/screens/product/widgets/color_accordion_widget.dart';
import 'package:danceattix/views/screens/product/widgets/variant_images_widget.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductVariantScreen extends StatefulWidget {
  const AddProductVariantScreen({super.key});

  @override
  State<AddProductVariantScreen> createState() => _AddProductVariantScreenState();
}

class _AddProductVariantScreenState extends State<AddProductVariantScreen> {
  final AddProductController _controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(title: 'Product Variants'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            /// ── Image upload section ──────────────────────────────────
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: CustomText(
                text: 'Upload Images',
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            const VariantImagesWidget(),

            /// ── Sizes & Stock section ─────────────────────────────────
            GetBuilder<AddProductController>(
              id: kIdColorList,
              builder: (controller) {
                if (controller.colorEntries.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.h),
                    Divider(color: AppColors.borderColor, thickness: 1, height: 1),
                    SizedBox(height: 20.h),

                    /// ── Header Row ────────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Sizes & Stock',
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 2.h),
                                CustomText(
                                  text: 'Tap a color card to set sizes & stock',
                                  fontSize: 11.sp,
                                  color: Colors.grey.withOpacity(0.45),
                                ),
                              ],
                            ),
                          ),

                          /// ── Total Stock Badge ──────────────────────
                          GetBuilder<AddProductController>(
                            id: kIdTotalStock,
                            builder: (c) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.inventory_2_outlined,
                                      size: 13.r,
                                      color: AppColors.primaryColor),
                                  SizedBox(width: 4.w),
                                  CustomText(
                                    text: '${c.totalStock()} units',
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    /// ── Color Accordion Cards ─────────────────────────
                    ...controller.colorEntries.map(
                          (e) => ColorAccordionCard(entry: e),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      /// ── Bottom Button ─────────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: GetBuilder<AddProductController>(
            builder: (controller) {
              // color বা size loading হলে button disabled
              final bool isLoading = controller.isLoadingAdd ||
                  controller.isColorsLoading ||
                  controller.isSizeLoading;

              return CustomButton(
                title: isLoading ? 'Please wait...' : 'Add Product',
                onpress:_controller.productsAdd,
              );
            },
          ),
        ),
      ),
    );
  }
}