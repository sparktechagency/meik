import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController offerPriceCtrl = TextEditingController();

  final List<Map<String, String>> productInfo = [
    {"label": "Category", "value": "Skirt"},
    {"label": "Brand", "value": "Lotto"},
    {"label": "Sizes", "value": "S(Small)"},
  ];

  @override
  void dispose() {
    offerPriceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image with back button
                  _buildProductImage(),

                  // Product Details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Title and Price
                        _buildTitleSection(),

                        SizedBox(height: 16.h),

                        // Product Tags
                        _buildProductTags(),

                        SizedBox(height: 16.h),

                        // Product Attributes
                        _buildProductAttributes(),

                        SizedBox(height: 20.h),

                        // Description
                        _buildDescriptionSection(),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
            child: CustomNetworkImage(
              height: 350.h,
              width: double.infinity,
              imageUrl: "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=600",
            ),
          ),
        ),
        Positioned(
          top: 50.h,
          left: 20.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Sheath Dress",
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),


        Spacer(),


        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: "\$ 21",
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            SizedBox(width: 8.w),
            Text(
              "\$32",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductTags() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: productInfo.map((info) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: CustomText(
            text: "${info["label"]}: ${info["value"]}",
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductAttributes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAttributeRow("Condition", "Brand New"),
        SizedBox(height: 8.h),
        _buildAttributeRow("Price type", "Negotiable"),
        SizedBox(height: 8.h),
        _buildAttributeRow("Size", "M, L, XL, XXL"),
        SizedBox(height: 8.h),
        _buildAttributeRow("Color", "Red, Black, Yellow, Green, Other"),
        SizedBox(height: 8.h),
        _buildAttributeRow("Materials", "Cotton, Linen, Polyster"),
      ],
    );
  }

  Widget _buildAttributeRow(String label, String value) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: CustomText(
              text: "$label :",
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: CustomText(
              text: value,
              fontSize: 13.sp,
              color: Colors.grey.shade600,
              textAlign: TextAlign.start,
              maxline: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Description",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "This facial cream is specially formulated to target and reduce dark spots, blemishes, and uneven skin tone. With its powerful ingredients, it helps fade discoloration and promotes a smoother, clearer complexion. Suitable for daily use, it nourishes the skin while working effectively to diminish spots and improve overall skin appearance.\n\nThis facial cream is specially formulated to target and reduce dark spots, blemishes, and uneven skin tone. With its powerful ingredients, it helps fade discoloration and promotes a smoother, clearer complexion.",
          fontSize: 12.sp,
          color: Colors.grey.shade600,
          maxline: 20,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.only(left: 24.w,right: 24.w, bottom: 30.h),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                title: "Buy Now",
                onpress: () {},
                loaderIgnore: true,
                borderRadius: 20.r,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomButton(
                borderRadius: 20.r,
                loaderIgnore: true,
                title: "Make offer",
                onpress: () => _showMakeOfferDialog(),
                height: 50.h,
                color: Colors.white,
                titlecolor: Colors.grey,
                boderColor: Colors.grey,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Assets.icons.message.svg(color: Colors.black45)
            ),
          ],
        ),
      ),
    );
  }

  void _showMakeOfferDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Make Offer",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 18.sp, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Product Info
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CustomNetworkImage(
                      imageUrl: "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=200",
                      height: 60.h,
                      width: 60.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Shift Dress",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Price: \$ 21",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Offer Price Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Offer your price",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "\$",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            controller: offerPriceCtrl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "12",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Make Offer Button
              CustomButton(
                loaderIgnore: true,
                title: "Make offer",
                onpress: () {
                  Navigator.pop(context);
                  // Handle offer submission
                },
                height: 50.h,
              ),
              SizedBox(height: 16.h),

              // Description
              CustomText(
                text: "This facial cream is specially formulated to target and reduce dark spots, blemishes, and uneven skin tone. With its powerful ingredients, it helps fade discoloration and promotes a smoother, clearer complexion. Suitable for daily use, it nourishes the skin while working effectively to diminish spots and improve overall skin appearance.",
                fontSize: 10.sp,
                color: Colors.grey,
                maxline: 10,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 16.h),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      loaderIgnore: true,
                      title: "Buy Now",
                      onpress: () => Navigator.pop(context),
                      height: 45.h,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      loaderIgnore: true,
                      title: "Make offer",
                      onpress: () => Navigator.pop(context),
                      height: 45.h,
                      color: Colors.white,
                      titlecolor: AppColors.primaryColor,
                      boderColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
