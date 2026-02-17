import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_home_product_card.dart';
import '../../widgets/custom_text.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double minPrice = 5;
  double maxPrice = 20;

  // Filter options
  List<String> conditions = ["Brand new", "Used"];
  String selectedCondition = "Used";

  List<String> productFor = ["Man", "Women", "Kids"];
  String selectedProductFor = "Women";

  List<String> brands = ["Lotto", "Zara", "Puma", "Levi's"];
  String selectedBrand = "Lotto";

  List<String> categories = ["Dress", "Shoes", "Clock"];
  String selectedCategory = "Dress";

  List<String> sizes = ["Small (S)", "Medium (M)", "Large (L)", "X-large (XL)", "XX-Large (XXL)", "XXX-Large (XXXL)"];
  List<String> selectedSizes = ["Small (S)", "Medium (M)"];

  List<String> colors = ["Red", "Green", "Range", "Blue", "Orange", "Pink", "Black"];
  List<String> selectedColors = ["Red", "Green", "Range"];

  List<String> materials = ["Cotton", "Linen", "Other"];
  List<String> selectedMaterials = ["Cotton"];

  final List<Map<String, dynamic>> productList = [
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=400"
    },
    {
      "title": "Women Printed Kurta",
      "description": "Neque porro quisquam est qui dolorem ipsum quia",
      "price": "\$1500",
      "oldPrice": "\$2499",
      "rating": 4.0,
      "reviews": "56890",
      "image": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400"
    },
  ];

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgColor,
      endDrawer: _buildFilterDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: "All Products",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: Icon(Icons.tune, color: Colors.black, size: 24.sp),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                _buildSearchBar(),
                SizedBox(height: 16.h),
                CustomText(
                  text: "Products (86)",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
          Expanded(
            child: _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Search by products name",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
            ),
          ),
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, color: Colors.white, size: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AnimationLimiter(
        child: GridView.builder(
          padding: EdgeInsets.only(bottom: 20.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
          ),
          itemCount: productList.length * 3,
          itemBuilder: (context, index) {
            final product = productList[index % productList.length];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: CustomHomeProductCard(
                    title: product["title"],
                    description: product["description"],
                    price: product["price"],
                    oldPrice: product["oldPrice"],
                    rating: product["rating"],
                    reviews: product["reviews"],
                    image: product["image"],
                    isFavorite: false,
                    onFavoriteTap: () {},
                    onBuyNowTap: () {},
                    onOfferTap: () {},
                    onMessageTap: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      width: 320.w,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, size: 20.sp),
                  ),
                  SizedBox(width: 16.w),
                  CustomText(
                    text: "Filter",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  const Spacer(),
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
            ),
            Divider(height: 1, color: Colors.grey.shade200),

            // Filter Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Range
                    CustomText(text: "Price Range", fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        _buildPriceBox("${minPrice.toInt()} \$"),
                        Expanded(
                          child: Container(
                            height: 2,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            color: Colors.grey.shade300,
                          ),
                        ),
                        _buildPriceBox("${maxPrice.toInt()} \$"),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: AppColors.primaryColor,
                        overlayColor: AppColors.primaryColor.withOpacity(0.2),
                        trackHeight: 4,
                      ),
                      child: RangeSlider(
                        values: RangeValues(minPrice, maxPrice),
                        min: 0,
                        max: 100,
                        divisions: 20,
                        onChanged: (values) {
                          setState(() {
                            minPrice = values.start;
                            maxPrice = values.end;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Products condition
                    _buildFilterSection("Products condition", conditions, selectedCondition, (val) {
                      setState(() => selectedCondition = val);
                    }),

                    // Products for
                    _buildFilterSection("Products for", productFor, selectedProductFor, (val) {
                      setState(() => selectedProductFor = val);
                    }),

                    // Brand
                    _buildFilterSection("Brand", brands, selectedBrand, (val) {
                      setState(() => selectedBrand = val);
                    }),

                    // Products category
                    _buildFilterSection("Products category", categories, selectedCategory, (val) {
                      setState(() => selectedCategory = val);
                    }),

                    // Size
                    _buildMultiFilterSection("Size", sizes, selectedSizes, (val) {
                      setState(() {
                        if (selectedSizes.contains(val)) {
                          selectedSizes.remove(val);
                        } else {
                          selectedSizes.add(val);
                        }
                      });
                    }),

                    // Color
                    _buildMultiFilterSection("Color", colors, selectedColors, (val) {
                      setState(() {
                        if (selectedColors.contains(val)) {
                          selectedColors.remove(val);
                        } else {
                          selectedColors.add(val);
                        }
                      });
                    }),

                    // Material
                    _buildMultiFilterSection("Material", materials, selectedMaterials, (val) {
                      setState(() {
                        if (selectedMaterials.contains(val)) {
                          selectedMaterials.remove(val);
                        } else {
                          selectedMaterials.add(val);
                        }
                      });
                    }),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),

            // Apply Button
            Padding(
              padding: EdgeInsets.all(20.r),
              child: CustomButton(
                title: "Buy now",
                onpress: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CustomText(text: text, fontSize: 12.sp, color: Colors.black),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((option) {
            final isSelected = selected == option;
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                  ),
                ),
                child: CustomText(
                  text: option,
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildMultiFilterSection(String title, List<String> options, List<String> selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((option) {
            final isSelected = selected.contains(option);
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                  ),
                ),
                child: CustomText(
                  text: option,
                  fontSize: 12.sp,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
