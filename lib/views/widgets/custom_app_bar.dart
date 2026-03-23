import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/global/custom_assets/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleSize = 22,
    this.centerTitle = true,
    this.titleWidget,
    this.flexibleSpace,
    this.showLeading = true,
    this.actions,
    this.backAction, this.leading, this.backgroundColor, this.borderColor, this.borderWidth, this.toolbarHeight,
  });

  final String? title;
  final double titleSize;
  final bool centerTitle;
  final Widget? titleWidget;
  final Widget? flexibleSpace;
  final bool showLeading;
  final Color? borderColor;
  final double? borderWidth;
  final List<Widget>? actions;
  final VoidCallback? backAction;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    return AppBar(
      toolbarHeight: toolbarHeight,
      titleSpacing: 0,
      shape: borderColor != null
          ? Border(
        bottom: BorderSide(color: borderColor ?? AppColors.primaryColor , width: borderWidth ?? 1),
      )
          : null,
      centerTitle: centerTitle,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? AppColors.bgColorWhite,
      scrolledUnderElevation: 0,
      flexibleSpace: flexibleSpace,
      leading: leading ??
          ((showLeading && (parentRoute?.canPop ?? false))
              ? IconButton(
            icon: Assets.icons.back.svg(height: 24.h,width: 24.w),
            onPressed: backAction ?? () => Navigator.pop(context),
          )
              : null),
      title: title != null && title!.isNotEmpty
          ? AutoTranslate(
            child: Text(
                    title!,
                    style: TextStyle(

            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w600,
            fontSize: titleSize.sp,
            color: AppColors.primaryColor,
                    ),
                  ),
          )
          : titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(toolbarHeight ?? 60);
}