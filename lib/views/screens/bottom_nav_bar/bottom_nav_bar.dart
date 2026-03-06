import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../home/home_screen.dart';
import '../message/message_user_screen.dart';
import '../post/post_screen.dart';
import '../product/product_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> screens = [
    const HomeScreen(),
    const PostScreen(),
    const MessageUserScreen(),
    const ProductScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        height: 65.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(35.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    bool isSelected = index == currentIndex;

    Widget getIcon(int idx, bool selected) {
      switch (idx) {
        case 0:
          return selected
              ? Assets.icons.home.svg(
                  width: 26.sp,
                  height: 26.sp,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )
              : Assets.icons.home.svg(
                  width: 26.sp,
                  height: 26.sp,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                );
        case 1:
          return Assets.icons.plus.svg(
            width: 26.sp,
            height: 26.sp,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          );
        case 2:
          return Assets.icons.message.svg(
            width: 26.sp,
            height: 26.sp,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          );
        case 3:
          return  Assets.icons.profile.svg(
                  width: 26.sp,
                  height: 26.sp,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                );
        default:
          return Assets.icons.home.svg(
            width: 26.sp,
            height: 26.sp,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          );
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black87.withOpacity(0.2) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: getIcon(index, isSelected),
      ),
    );
  }
}
