import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoader extends StatelessWidget {
  final double? top;
  final double? bottom;
  const CustomLoader({super.key, this.top, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0),
      child: SpinKitCircle(
        color: AppColors.primaryColor,
        size: 48.h
      ),
    );
  }
}
