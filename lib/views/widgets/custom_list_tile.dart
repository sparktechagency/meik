import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/widgets/custom_image_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/widgets.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, this.title, this.subTitle, this.image, this.imageRadius = 18, this.trailing,  this.selectedColor, this.onTap, this.activeColor, this.statusColor, this.borderColor, this.borderRadius, this.titleFontSize, this.subtitleFontSize, this.titleColor, this.contentPaddingHorizontal, this.contentPaddingVertical,});

  final String? title,subTitle,image;
  final double imageRadius;
  final Widget? trailing;
  final Color? selectedColor;
  final VoidCallback? onTap;
  final Color? activeColor;
  final Color? statusColor;
  final Color? borderColor;
  final Color? titleColor;
  final double? borderRadius;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      tileColor: selectedColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),      onTap: onTap,
      //selectedColor: selectedColor,
     // selected: selectedColor != null ? true : false,
      contentPadding: EdgeInsets.symmetric(horizontal: contentPaddingHorizontal ?? 6.h ,vertical: contentPaddingVertical ?? 0),
      leading:  Stack(
        children: [
          CustomImageAvatar(
            radius: imageRadius.r,
            image: image,
          ),
          if(activeColor != null)
          Positioned(
            right: 0.w,
              bottom: 0.h,
              child: CustomContainer(
                paddingAll: 1,
                shape: BoxShape.circle,
                color: Colors.white,
                  child: Icon(Icons.circle,color: activeColor,size: 12.r,))),
        ],
      ),
      title: CustomText(
        color: titleColor,
        textAlign: TextAlign.left,
        text: title ?? '',
        fontSize: titleFontSize ?? 16.sp,
        fontWeight:  FontWeight.w500,
      ),
      subtitle: subTitle != null ? CustomText(
        left: 4,
        textAlign: TextAlign.left,
        text: subTitle ??'',
        fontWeight:  FontWeight.w500,
        fontSize: subtitleFontSize ?? 10.sp,
        color: statusColor ?? AppColors.dividerColor,
      ) : null,
      trailing: trailing != null
          ? ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 100.w, // <- Adjust to suit your button size
        ),
        child: trailing!,
      )
          : null,
    );
  }
}
