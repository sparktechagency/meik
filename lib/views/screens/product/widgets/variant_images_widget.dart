
import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/views/screens/product/widgets/color_picker_dialog_widget.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VariantImagesWidget extends StatelessWidget {
  const VariantImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
      id: kIdImageList,
      builder: (c) => SizedBox(
        height: 150.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: c.images.length + 1, // +1 for the upload card slot only
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (ctx, i) => i == 0
              ? c.isUploadImage
              ? CustomLoader()
              : _buildUploadCard(ctx)
              : _buildImageCard(i - 1, ctx),
        ),
      ),    );
  }

  /// ── Upload card ──────────────────────────────────────────────────────────────

  Widget _buildUploadCard(BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (c) {
        return GestureDetector(
          onTap: () => c.addPhoto(context),
          child: CustomContainer(
            width: 100.w,
            height: 150.h,
            color: Colors.white,
            radiusAll: 12.r,
            bordersColor: AppColors.borderColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                  height: 44.r,
                  width: 44.r,
                  color: AppColors.borderColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                  child: Center(
                    child: Assets.icons.attachfileIcon.svg(
                      height: 22.r,
                      width: 22.r,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  maxline: 1,
                  text: 'Add Photo',
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: '${c.images.length}/5',
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 10.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ── Image card ───────────────────────────────────────────────────────────────
  Widget _buildImageCard(int index, BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (controller) {
        final isPickMode = controller.pickerIndex == index;
        final pickedColor = controller.colorAt(index);
        return SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Color tag button ──
              GestureDetector(
                onTap: () => controller.togglePickerMode(index),
                child: CustomContainer(
                  width: 100.w,
                  paddingHorizontal: 6.w,
                  paddingVertical: 3.h,
                  color: isPickMode
                      ? AppColors.primaryColor
                      : pickedColor ?? AppColors.borderColor.withOpacity(0.3),
                  radiusAll: 6.r,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isPickMode
                            ? Icons.colorize
                            : pickedColor != null
                            ? Icons.circle
                            : Icons.colorize_outlined,
                        size: 11.r,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3.w),
                      Flexible(
                        child: CustomText(
                          maxline: 1,
                          text: isPickMode
                              ? 'Tap image...'
                              : pickedColor != null
                              ? '#${controller.hex(pickedColor)}'
                              : 'Pick Color',
                          fontSize: 9.sp,
                          color: pickedColor != null || isPickMode
                              ? Colors.white
                              : Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),

              // ── Image ──
              GestureDetector(
                onTap: isPickMode
                    ? () async {
                        final color = await showDialog<Color>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              ColorPickerDialog(file: controller.images[index]),
                        );
                        if (color != null) {
                          controller.setColorForImage(index, color);
                        }
                      }
                    : null,
                child: SizedBox(
                  width: 100.w,
                  height: 120.h,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(controller.images[index], fit: BoxFit.cover),
                        Positioned(
                          top: 6.h,
                          right: 6.w,
                          child: GestureDetector(
                            onTap: () => controller.removePhoto(index),
                            child: Assets.icons.clean.svg(
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                        if (isPickMode)
                          CustomContainer(
                            bordersColor: AppColors.primaryColor,
                            radiusAll: 12.r,
                            color: AppColors.primaryColor.withOpacity(0.08),
                            child: Center(
                              child: Icon(
                                Icons.colorize,
                                color: Colors.white.withOpacity(0.9),
                                size: 28.r,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
