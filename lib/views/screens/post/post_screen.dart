
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_product_card.dart';
import '../../widgets/custom_text.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  List purchasedList = ["In progress", "Handover on delivery man", "Received", "In progress"];

  List historyList = ["Complete", "Complete", "Cancel", "Cancel"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Products History."),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 45.h,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            ),
            tabs: const [
              Text('        Favorite         '),
              Text('         Purchased        '),
              Text('         History       '),
            ],
            views: [
              AnimationLimiter(
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  itemBuilder: (context, index) {
                    return CustomProductCard(
                      index: index,
                      leftBtnName: "Buy now",
                      rightBtnName: "Message",
                      isBookMarkNeed: true,
                      isFavorite: true,
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





              AnimationLimiter(
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








              AnimationLimiter(
                child: ListView.builder(
                  itemCount: historyList.length,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  itemBuilder: (context, index) {
                    return CustomProductCard(
                      index: index,
                      isBookMarkNeed: true,
                      isFavorite: false,
                      isHistory: true,
                      progressStatus: "${historyList[index]}",
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





            ],
            onChange: (index) => print("Tab index changed to $index"),
          ),
        ));
  }
}
