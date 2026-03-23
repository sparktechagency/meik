import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxline,
    this.textOverflow,
    this.fontName,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize,
    this.textHeight,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.text = "",
    this.letterSpacing,
    this.textDecoration,
    this.enableAutoTranslate = true,
  });

  final double left;
  final TextOverflow? textOverflow;
  final double right;
  final double top;
  final double bottom;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final TextAlign textAlign;
  final int? maxline;
  final String? fontName;
  final double? textHeight;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final bool enableAutoTranslate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: AutoTranslate(
        enable: enableAutoTranslate,
        loadingWidget: Text('...'),
        child: Text(
          textAlign: textAlign,
          text,
          maxLines: maxline,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: fontSize ?? 14.h,
            fontFamily: fontName ?? "Poppins",
            fontWeight: fontWeight,
            color: color ?? AppColors.textColorA0A0A,
            letterSpacing: letterSpacing,
            decoration: textDecoration,
            decorationColor: color ?? AppColors.textColorA0A0A,
          ),
        ),
      ),
    );
  }
}
