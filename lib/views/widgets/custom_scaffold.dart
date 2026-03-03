import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.paddingSide, this.resizeToAvoidBottomInset, this.endDrawer});

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? endDrawer;
  final double? paddingSide;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
      appBar: appBar,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: paddingSide ?? 16.w,right: paddingSide ?? 16.w),
        child: body,
      )),
      floatingActionButton: floatingActionButton,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset
    );
  }
}
