
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List purchasedList = ["In progress", "Handover on delivery man", "Received", "In progress"];

  List historyList = ["Complete", "Complete", "Cancel", "Cancel"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Products History."),
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.createProductScreen);
          },
          child: Padding(
            padding:  EdgeInsets.only(bottom: 80.h),
            child: Container(
              height: 53.h,
              width: 53.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor
              ),
              child: Icon(Icons.add, color: Colors.white,size: 24.r),
            ),
          ),
        ),
        body: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            height: 40.h,
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.black,
            labelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 14.sp,color: AppColors.dividerColor),
          ),
          tabs: const [
            Text('Listed: 5'),
            Text('Pending: 2'),
            Text('Sold: 3'),
          ],
          views: [
            AnimationLimiter(
              child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w),
                itemBuilder: (context, index) {
                  return CustomMyProductCard(
                    index: index,
                    leftBtnName: "Buy now",
                    isBookMarkNeed: true,
                    isFavorite: true,
                    boast: index == 0 ? "Boosted on 22 Nov" : "Boost now",
                    title: "Shift Dress",
                    price: "30",
                    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO4tTg47BvvepOyh9V-dEmXe0b65R_jFkWX0RV1u3hHisNTVPXqk3h0HiyKynTVoso0X0&usqp=CAU",
                    onTap: () {
                      Get.toNamed(AppRoutes.productDetailsScreen);
                    },
                    boostOnTap: () {
                      Get.toNamed(AppRoutes.boostScreen);
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
                  return CustomMyProductCard(
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
                  return CustomMyProductCard(
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
        ));
  }
}







class CustomMyProductCard extends StatefulWidget {
  final int? index;
  final String? title;
  final String? price;
  final String? image;
  final String? progressStatus;
  final String? leftBtnName;
  final String? rightBtnName;
  final String? boast;
  final bool? isFavorite;
  final bool isHistory;
  final bool? isBookMarkNeed;
  final VoidCallback? onTap;
  final VoidCallback? boostOnTap;

  const CustomMyProductCard(
      {super.key,
        this.index,
        this.title,
        this.price,
        this.image,
        this.isFavorite,
        this.onTap,
        this.leftBtnName,
        this.rightBtnName,
        this.isBookMarkNeed,
        this.progressStatus, this.isHistory = false, this.boast, this.boostOnTap});

  @override
  State<CustomMyProductCard> createState() => _CustomMyProductCardState();
}

class _CustomMyProductCardState extends State<CustomMyProductCard> {

  final List<String> _options = ['Packed', 'Hand over delivery man', 'Complete'];
  String _selected = 'Packed';


  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: widget.index ?? 0,
      columnCount: 2,
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50,
        child: SlideAnimation(
          delay: Duration(milliseconds: 275),
          child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 0), // shadow in all directions
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section

                      CustomNetworkImage(
                          borderRadius: BorderRadius.circular(8.r),
                          imageUrl: "${widget.image}",
                          height:  142.h,
                          width: 102.w),

                      SizedBox(width: 7.w),

                      // Info Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                CustomText(
                                    text: "${widget.title}",
                                    fontWeight: FontWeight.w600,
                                    bottom: 4.h,
                                    color: Colors.black),
                                Spacer(),
                                if (widget.isBookMarkNeed ?? false)
                                  widget.isFavorite ?? false ?
                                      Row(
                                        children: [

                                          Container(
                                            height: 25.h,
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.r),
                                                color: AppColors.primaryColor
                                            ),
                                            child: Icon(Icons.edit, color: Colors.white, size: 16.h),
                                          ),



                                          SizedBox(width: 8.w),


                                          Container(
                                            height: 25.h,
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.r),
                                                color: AppColors.primaryColor
                                            ),
                                            child: Icon(Icons.delete_outline_sharp, color: Colors.white, size: 16.h),
                                          ),


                                        ],
                                      ) : SizedBox()
                              ],
                            ),
                            SizedBox(height: 8.h),
                            CustomText(
                                text: "Price: 30\$",
                                fontWeight: FontWeight.w500, bottom: 8.h),
                            CustomText(
                                maxline: 3,
                                text:
                                "Transform your look with expert cuts, styling, and personalized service at our premier salon, designed for your ultimate satisfaction.",
                                fontSize: 10.h,
                                textAlign: TextAlign.start,
                                bottom: 4.h,
                                color: Colors.black),
                            SizedBox(height: 10.h),



                            if(widget.isHistory)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomText(text: "Set Status", fontSize: 11.h),

                                  Container(
                                    height: 26.h,
                                    width: double.infinity,
                                    padding:  EdgeInsets.symmetric(horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black38),
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selected,
                                        icon: const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black87),
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        style: const TextStyle(color: Colors.black),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              _selected = newValue;
                                            });
                                          }
                                        },
                                        items: _options.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            if(widget.boast != null)
                              CustomButton(
                                color: widget.boast == "Boost now" ? AppColors.primaryColor : Color(0xffEFF8F8),
                                boderColor:  widget.boast == "Boost now" ? AppColors.primaryColor : Colors.transparent,
                                  titlecolor:  widget.boast == "Boost now" ? Colors.white : AppColors.primaryColor,
                                  height: 30.h,
                                  fontSize: 12.h,
                                  width: 140.w,
                                  loaderIgnore: true,
                                  title: "${widget.boast}", onpress: widget.boostOnTap ?? (){})



                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
