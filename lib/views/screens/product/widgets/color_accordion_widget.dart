
import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/views/screens/product/widgets/stock_row_widget.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ColorAccordionCard extends StatelessWidget {
  final ColorEntry entry;

  const ColorAccordionCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
      id: kIdAccordion(entry.hex),
      builder: (c) {
        final isOpen = c.expandedHex == entry.hex;
        final sizes = c.colorSizes[entry.hex] ?? {};
        final isComplete = sizes.isNotEmpty;

        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isOpen
                    ? AppColors.primaryColor.withOpacity(0.55)
                    : isComplete
                    ? AppColors.primaryColor.withOpacity(0.2)
                    : AppColors.borderColor,
                width: isOpen ? 1.6 : 1.1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isOpen
                      ? AppColors.primaryColor.withOpacity(0.08)
                      : Colors.black.withOpacity(0.03),
                  blurRadius: isOpen ? 16 : 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => c.toggleAccordion(entry.hex),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      color: isOpen
                          ? AppColors.primaryColor.withOpacity(0.03)
                          : Colors.transparent,
                      borderRadius: isOpen
                          ? BorderRadius.vertical(top: Radius.circular(13.r))
                          : BorderRadius.circular(13.r),
                    ),
                    child: Row(
                      children: [
                        // Thumbnail with color ring
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: entry.color, width: 3),
                            image: DecorationImage(
                              image: FileImage(c.images[entry.imageIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Color info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 11.r,
                                    height: 11.r,
                                    decoration: BoxDecoration(
                                      color: entry.color,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: entry.color.withOpacity(0.45),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  CustomText(
                                    text: '#${entry.hex}',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              isComplete
                                  ? CustomText(
                                      text:
                                          '${sizes.length} size${sizes.length > 1 ? 's' : ''} · ${c.colorStock(entry.hex)} units',
                                      fontSize: 10.sp,
                                      color: AppColors.primaryColor,
                                    )
                                  : CustomText(
                                      text: 'Tap to select sizes & add stock',
                                      fontSize: 10.sp,
                                      color: Colors.grey.withOpacity(
                                        0.4,
                                      ),
                                    ),
                            ],
                          ),
                        ),

                        // Preview chips
                        if (isComplete && !isOpen) ...[
                          Wrap(
                            spacing: 3.w,
                            children: sizes
                                .take(3)
                                .map(
                                  (s) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: CustomText(
                                      text: s,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          if (sizes.length > 3) ...[
                            SizedBox(width: 3.w),
                            CustomText(
                              text: '+${sizes.length - 3}',
                              fontSize: 9.sp,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],
                          SizedBox(width: 6.w),
                        ],

                        // Chevron
                        AnimatedRotation(
                          turns: isOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 220),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22.r,
                            color: isOpen
                                ? AppColors.primaryColor
                                :                               Colors.grey.withOpacity(0.35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isOpen) ...[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.borderColor.withOpacity(0.7),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Size chips header ──
                        Row(
                          children: [
                            CustomText(
                              text: 'Select Sizes',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            const Spacer(),
                            GetBuilder<AddProductController>(
                              id: kIdSizes(entry.hex),
                              builder: (c) =>
                                  (c.colorSizes[entry.hex]?.isNotEmpty ?? false)
                                  ? GestureDetector(
                                      onTap: () => c.clearSizes(entry.hex),
                                      child: CustomText(
                                        text: 'Clear all',
                                        fontSize: 10.sp,
                                        color: Colors.red.withOpacity(0.6),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // ── Size chips ──
                        GetBuilder<AddProductController>(
                          id: kIdSizes(entry.hex),
                          builder: (c) {
                            final currentSizes = c.colorSizes[entry.hex] ?? {};
                            return Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: kSizes.map((size) {
                                final selected = currentSizes.contains(size);
                                return GestureDetector(
                                  onTap: () => c.toggleSize(entry.hex, size),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.primaryColor
                                            : AppColors.borderColor,
                                        width: selected ? 0 : 1.2,
                                      ),
                                      boxShadow: selected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.28),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: CustomText(
                                      enableAutoTranslate: false,
                                      text: size,
                                      fontSize: 12.sp,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: selected
                                          ? Colors.white
                                          :                               Colors.grey,

                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),

                        // ── Stock per size ──
                        GetBuilder<AddProductController>(
                          id: kIdSizes(entry.hex),
                          builder: (c) {
                            final currentSizes = c.colorSizes[entry.hex] ?? {};
                            if (currentSizes.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18.h),
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: AppColors.borderColor.withOpacity(0.4),
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Stock per Size',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    const Spacer(),
                                    GetBuilder<AddProductController>(
                                      id: kIdTotalStock,
                                      builder: (c) => CustomText(
                                        text:
                                            'Total: ${c.colorStock(entry.hex)} units',
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                ...currentSizes.map(
                                  (size) => StockRowWidget(
                                    hex: entry.hex,
                                    color: entry.color,
                                    size: size,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
