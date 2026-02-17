import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';


class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Media"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 3,
                    childAspectRatio: 0.811),
                itemBuilder: (context, index) {
                  return CustomNetworkImage(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primaryColor, width: 0.2),
                      imageUrl:
                          "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
