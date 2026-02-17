import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/cachanetwork_image.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: "Cart"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ContainedTabBarView(
            tabBarProperties: TabBarProperties(
              height: 45.h,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              labelStyle:
              TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            ),
            tabs: const [
              Text('                    My Cart                 '),
              Text('           Purchase History          '),
            ],
            views: [
              _buildCartList(),
              _purchaseHistory(),
            ],
            onChange: (index) => print("Tab index changed to $index"),
          ),
        ));
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: const Color(0xfffef4ea), // Card background
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
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section

                CustomNetworkImage(
                    borderRadius: BorderRadius.circular(8.r),
                    imageUrl:
                    "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                    height: 139.h,
                    width: 109.w),

                SizedBox(width: 7.w),

                // Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Cat Travel Bag (Used)",
                          fontWeight: FontWeight.w600,
                          bottom: 4.h,
                          color: Colors.black),
                      Row(
                        children: [
                          Assets.icons.moneyIconCard.svg(),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "30\$",
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      CustomText(
                          text: "Pet Type: Cat",
                          fontSize: 12.h,
                          bottom: 4.h,
                          color: Colors.black),
                      CustomText(
                        text: "Condition: Used – 60% Usable",
                        fontSize: 12.h,
                        bottom: 4.h,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: "Location: Banani, Dhaka",
                        fontSize: 12.h,
                        color: Colors.black,
                        bottom: 7.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                height: 26.h,
                                title: "Offer Price",
                                onpress: () {
                                  TextEditingController amonCtrl =
                                  TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                                text: "Offer Your Price",
                                                fontSize: 16.h,
                                                fontWeight: FontWeight.w600,
                                                top: 29.h,
                                                bottom: 20.h,
                                                color: Color(0xff592B00)),
                                            Divider(),
                                            SizedBox(height: 12.h),
                                            CustomTextField(
                                                controller: amonCtrl,
                                                labelText: "Enter Amount",
                                                hintText: "Enter Amount"),
                                            SizedBox(height: 12.h),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      height: 50.h,
                                                      title: "Cancel",
                                                      onpress: () {},
                                                      color: Colors.transparent,
                                                      fontSize: 11.h,
                                                      loaderIgnore: true,
                                                      boderColor: AppColors
                                                          .primaryColor,
                                                      titlecolor: AppColors
                                                          .primaryColor),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      loading: false,
                                                      loaderIgnore: true,
                                                      height: 50.h,
                                                      title: "Offer",
                                                      onpress: () {
                                                        Get.toNamed(AppRoutes
                                                            .messageScreen);
                                                      },
                                                      fontSize: 11.h),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                color: Colors.transparent,
                                fontSize: 11.h,
                                loaderIgnore: true,
                                boderColor: AppColors.primaryColor,
                                titlecolor: AppColors.primaryColor),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                loading: false,
                                loaderIgnore: true,
                                height: 26.h,
                                title: "Purchase",
                                onpress: () {},
                                fontSize: 11.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  final List<Map<String, dynamic>> purchaseList = [
    {
      "title": "Cat Travel Bag (Used)",
      "price": "30\$",
      "location": "Banani, Dhaka",
      "date": "12 June",
      "status": "In Progress",
      "image":
      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773"
    },
    {
      "title": "Cat Travel Bag (Used)",
      "price": "30\$",
      "location": "Banani, Dhaka",
      "date": "12 June",
      "status": "Packed",
      "image":
      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773"
    },
    {
      "title": "Cat Travel Bag (Used)",
      "price": "30\$",
      "location": "Banani, Dhaka",
      "date": "12 June",
      "status": "Handover",
      "image":
      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773"
    },
    {
      "title": "Cat Travel Bag (Used)",
      "price": "30\$",
      "location": "Banani, Dhaka",
      "date": "12 June",
      "status": "Completed",
      "image":
      "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773"
    },
  ];


  Widget _purchaseHistory() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20.h),
      itemCount: purchaseList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: const Color(0xfffef4ea), // Card background
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
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section

                CustomNetworkImage(
                    borderRadius: BorderRadius.circular(8.r),
                    imageUrl:
                    "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                    height: 139.h,
                    width: 109.w),

                SizedBox(width: 7.w),

                // Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          CustomText(
                              text: "Cat Travel Bag (Used)",
                              fontWeight: FontWeight.w600,
                              bottom: 4.h,
                              color: Colors.black),

                        ],
                      ),


                      Row(
                        children: [
                          Assets.icons.moneyIconCard.svg(),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "30\$",
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),


                      CustomText(
                        text: "Location: Banani, Dhaka",
                        fontSize: 12.h,
                        color: Colors.black,
                        bottom: 7.h,
                      ),

                      CustomText(
                        text: "Date of purchase: 12 june",
                        fontSize: 12.h,
                        bottom: 4.h,
                        color: Colors.black,
                      ),

                      Row(
                        children: [
                          CustomText(text: "Status", color: Colors.black),
                          Spacer(),


                          Container(
                            decoration: BoxDecoration(
                              color: purchaseList[index]["status"]
                                  .toString()
                                  .toLowerCase() == "packed" ? Color(0xffCCE7FF) :
                              purchaseList[index]["status"]
                                  .toString()
                                  .toLowerCase() == "handover" ? Color(0xffD1F5D3) :
                              Color(0xffFFF4CC),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 0), // shadow in all directions
                                ),
                              ],
                            ),

                            child: CustomText(
                              text: "${purchaseList[index]["status"]}",
                              left: 8.w,
                              right: 8.w,),
                          ),
                        ],
                      ),


                      SizedBox(height: 12.h),


                      purchaseList[index]["status"].toString().toLowerCase() == "handover" ?
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                child: CustomText(text: "I’ve Received the Product", color: Colors.white, fontSize: 12.h),
                              ),
                            ),
                          ) :
                      purchaseList[index]["status"].toString().toLowerCase() == "completed"  ?

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                height: 26.h,
                                title: "Request Refund",
                                onpress: () {
                                  Get.toNamed(AppRoutes.refundRequestScreen);
                                },
                                color: Colors.transparent,
                                fontSize: 9.h,
                                loaderIgnore: true,
                                boderColor: AppColors.primaryColor,
                                titlecolor: AppColors.primaryColor),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                                loading: false,
                                loaderIgnore: true,
                                height: 26.h,
                                title: "Rate Seller",
                                onpress: () {



                                  TextEditingController amonCtrl =
                                  TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                                text: "Rate Your Experience",
                                                fontSize: 16.h,
                                                fontWeight: FontWeight.w600,
                                                top: 29.h,
                                                bottom: 20.h,
                                                color: Color(0xff592B00)),
                                            Divider(),


                                            CustomText(top: 7.h,bottom: 6.h, text: "Product Summary Card", color: Colors.black),



                                            Row(
                                              children: [
                                                CustomNetworkImage(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    imageUrl:
                                                    "https://www.petzlifeworld.in/cdn/shop/files/51e-nUlZ50L.jpg?v=1719579773",
                                                    height: 71.h,
                                                    width: 61.w),

                                                SizedBox(width: 12.w),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    CustomText(text: "Cat Travel Bag", color: Colors.black),
                                                    CustomText(text: "Banani, Dhaka", color: Colors.black, fontSize: 12.h),
                                                    CustomText(text: "Original Price: \$30", color: Colors.black, fontSize: 12.h),

                                                  ],
                                                )
                                              ],
                                            ),


                                            // CustomText(top: 7.h,bottom: 6.h, text: "Seller Info", color: Colors.black),
                                            //
                                            // Row(
                                            //   children: [
                                            //
                                            //     CustomNetworkImage(imageUrl: "", height: 34.h, width: 34.w, boxShape: BoxShape.circle),
                                            //
                                            //
                                            //     SizedBox(width: 10.w),
                                            //     Column(
                                            //       crossAxisAlignment: CrossAxisAlignment.start,
                                            //       children: [
                                            //
                                            //         CustomText(text: " Sarah Rahman", color: Colors.black87),
                                            //         Row(
                                            //           children: [
                                            //             CustomText(text: "⭐ 4.8 | Verified Seller", color: Colors.black87),
                                            //           ],
                                            //         ),
                                            //
                                            //
                                            //       ],
                                            //     )
                                            //
                                            //
                                            //   ],
                                            // ),

                                          SizedBox(height: 12.h),

                                          Align(
                                            alignment: Alignment.center,
                                            child: RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemSize: 22,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ),

                                            SizedBox(height: 12.h),
                                            CustomTextField(
                                                controller: amonCtrl,
                                                hintText: "Review"),


                                            CustomText(fontSize: 12.h,text: " Please Leave A Review For this service.", color: AppColors.primaryColor, bottom: 18.h),


                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      height: 50.h,
                                                      title: "Cancel",
                                                      onpress: () {},
                                                      color: Colors.transparent,
                                                      fontSize: 11.h,
                                                      loaderIgnore: true,
                                                      boderColor: AppColors
                                                          .primaryColor,
                                                      titlecolor: AppColors
                                                          .primaryColor),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomButton(
                                                      loading: false,
                                                      loaderIgnore: true,
                                                      height: 50.h,
                                                      title: "Submit",
                                                      onpress: () {
                                                        Get.toNamed(AppRoutes
                                                            .messageScreen);
                                                      },
                                                      fontSize: 11.h),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );



                                },
                                fontSize: 9.h),
                          ),
                        ],
                      ) : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
