import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockRowWidget extends StatelessWidget {
  final String hex;
  final Color color;
  final String size;

  const StockRowWidget({
    super.key,
    required this.hex,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GetBuilder<AddProductController>(
        id: kIdStock(hex, size),
        builder: (c) {
          final ctrl = c.ctrl(hex, size);
          final value = int.tryParse(ctrl.text) ?? 0;

          return Row(
            children: [
              // Size pill
              Container(
                width: 46.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(color: color.withOpacity(0.35)),
                ),
                child: Center(
                  child: CustomText(
                    text: size,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Stepper
              Expanded(
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.borderColor.withOpacity(0.45),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildStepBtn(
                        isLeft: true,
                        icon: Icons.remove,
                        btnColor: null,
                        onTap: () => c.decrementStock(hex, size),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: ctrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (_) => c.onStockChanged(hex, size),
                        ),
                      ),
                      _buildStepBtn(
                        isLeft: false,
                        icon: Icons.add,
                        btnColor: AppColors.primaryColor,
                        onTap: () => c.incrementStock(hex, size),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10.w),
              SizedBox(
                width: 38.w,
                child: CustomText(
                  text: '$value pcs',
                  fontSize: 10.sp,
                  color: value > 0
                      ? AppColors.primaryColor
                      : Colors.grey.withOpacity(0.35),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepBtn({
    required bool isLeft,
    required IconData icon,
    Color? btnColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: double.infinity,
        decoration: BoxDecoration(
          color: btnColor != null
              ? btnColor.withOpacity(0.1)
              : AppColors.borderColor.withOpacity(0.3),
          borderRadius: isLeft
              ? BorderRadius.horizontal(left: Radius.circular(9.r))
              : BorderRadius.horizontal(right: Radius.circular(9.r)),
        ),
        child: Icon(
          icon,
          size: 16.r,
          color: btnColor ?? Colors.grey.withOpacity(0.55),
        ),
      ),
    );
  }
}
