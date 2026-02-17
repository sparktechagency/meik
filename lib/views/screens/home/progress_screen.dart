import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../core/config/app_route.dart';
import '../../widgets/custom_product_card.dart';

class ProgressScreen extends StatelessWidget {
   ProgressScreen({super.key});

  List purchasedList = ["In progress", "Handover on delivery man", "Received", "In progress"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Progress"),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [







            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: purchasedList.length,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  itemBuilder: (context, index) {
                    return CustomProductCard(
                      index: index,
                      isBookMarkNeed: true,
                      isFavorite: false,
                      progressStatus: "${purchasedList[index]}",
                      title: "Shift Dress",
                      price: "30",
                      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO4tTg47BvvepOyh9V-dEmXe0b65R_jFkWX0RV1u3hHisNTVPXqk3h0HiyKynTVoso0X0&usqp=CAU",
                      onTap: () {
                        Get.toNamed(AppRoutes.productDetailsScreen);
                      },
                    );
                  },
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
