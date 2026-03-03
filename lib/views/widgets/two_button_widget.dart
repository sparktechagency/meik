// import 'package:danceattix/core/app_constants/app_colors.dart';
// import 'package:danceattix/views/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class TwoButtonWidget extends StatelessWidget {
//   final List<Map<String, String>> buttons;
//   final String selectedValue;
//   final Function(String) onTap;
//   final double? fontSize;
//   final Color? selectedBgColor;
//   final Color? bgColor;
//
//   const TwoButtonWidget({
//     super.key,
//     required this.buttons,
//     required this.selectedValue,
//     required this.onTap, this.fontSize, this.selectedBgColor, this.bgColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: buttons.map((item) {
//         final isSelected = item['value'] == selectedValue;
//         return Expanded(
//           child: GestureDetector(
//             onTap: () => onTap(item['value']!),
//             child: CustomContainer(
//               bordersColor: isSelected ? (selectedBgColor ?? Color(0xff3E513E)) : (bgColor ?? AppColors.black100TextColor),
//               horizontalMargin: 10.w,
//               radiusAll: 12.r,
//               paddingVertical: 8.h,
//               color: isSelected ? (selectedBgColor ?? Color(0xff3E513E)) : (bgColor ?? Colors.transparent) ,
//               child: CustomText(
//                 text: item['label']!,
//                 color: isSelected ? Colors.white : AppColors.black600TextColor,
//                 fontSize: fontSize ?? 15.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
