import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? boderColor;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool loading;
  final bool loaderIgnore;
  final Widget? leftIcon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.boderColor,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.leftIcon,
    this.loading = false,
    this.loaderIgnore = false,
    this.fontWeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onpress,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          border: Border.all(color: boderColor ?? AppColors.primaryColor),
          color: color ?? AppColors.primaryColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ✅ Title always perfectly centered
            Center(
              child: CustomText(
                text: title,
                fontSize: fontSize ?? 16.h,
                color: titlecolor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),

            // Left icon
            if (leftIcon != null)
              Positioned(
                left: 8.w,
                child: leftIcon!,
              ),

            // Loader on the right
            if (!loaderIgnore)
              Positioned(
                right: 4.w,
                child: SizedBox(
                  height: 25.h,
                  width: 25.w,
                  child: loading
                      ?  CircularProgressIndicator(
                          color: titlecolor ?? Colors.white,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}