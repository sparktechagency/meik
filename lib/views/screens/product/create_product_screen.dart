import 'dart:io';

import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController titleNameCtrl = TextEditingController();
  final TextEditingController purchasePriceCtrl = TextEditingController();
  final TextEditingController offerPriceCtrl = TextEditingController();

  // Selected values for dropdowns
  String? selectedProductsFor;
  String? selectedCategory;
  String? selectedCondition;
  String? selectedBrandName;
  String? selectedPriceType;

  // Multi-select lists
  List<String> selectedColors = [];
  List<String> selectedMaterials = [];
  List<String> selectedSizes = [];

  // Dropdown options
  final List<String> productsForList = ['Woman', 'Man', 'Kids', 'Unisex'];
  final List<String> categoryList = ['Cloth', 'Shoes', 'Accessories', 'Bags'];
  final List<String> conditionList = [
    'Brand New',
    'Use less than 6 month',
    'Use less than 1 years',
    'Use more then 1 years'
  ];
  final List<String> colorList = ['Black', 'Red', 'Yellow', 'Blue', 'Green', 'White', 'Pink'];
  final List<String> materialList = ['Cotton', 'Linen', 'Polyester', 'Silk', 'Wool'];
  final List<String> sizeList = ['XS', 'S', 'M - Medium', 'L - Large', 'XL', 'XXL'];
  final List<String> brandNamesList = ['Lotto', 'Zara', 'Easy', 'Puma', 'Adidas', 'No tags'];
  final List<String> priceTypeList = ['Negotiable', 'Fixed'];

  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  @override
  void dispose() {
    titleNameCtrl.dispose();
    purchasePriceCtrl.dispose();
    offerPriceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Add Products"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Title or name
                    _buildLabel("Title or name."),
                    _buildTextField(
                      controller: titleNameCtrl,
                      hintText: "Write here",
                    ),
                    CustomText(
                      text: "this field less than 20 characters.",
                      fontSize: 12.sp,
                      color: const Color(0xffE57373),
                      top: 6.h,
                    ),
                    SizedBox(height: 12.h),

                    // Products for
                    _buildLabel("Products for"),
                    _buildDropdownField(
                      value: selectedProductsFor,
                      hintText: "Select",
                      onTap: () => _showSelectionBottomSheet(
                        title: "Products for",
                        items: productsForList,
                        selectedValue: selectedProductsFor,
                        onSelect: (value) {
                          setState(() => selectedProductsFor = value);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Category
                    _buildLabel("Category"),
                    _buildDropdownField(
                      value: selectedCategory,
                      hintText: "Select",
                      onTap: () => _showSelectionBottomSheet(
                        title: "Category",
                        items: categoryList,
                        selectedValue: selectedCategory,
                        onSelect: (value) {
                          setState(() => selectedCategory = value);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Condition
                    _buildLabel("Condition"),
                    _buildDropdownField(
                      value: selectedCondition,
                      hintText: "Select",
                      onTap: () => _showSelectionBottomSheet(
                        title: "Condition",
                        items: conditionList,
                        selectedValue: selectedCondition,
                        onSelect: (value) {
                          setState(() => selectedCondition = value);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Color - Multi-select
                    _buildLabel("Color"),
                    _buildMultiSelectSection(
                      selectedItems: selectedColors,
                      onAddTap: () => _showMultiSelectBottomSheet(
                        title: "Select Colors",
                        items: colorList,
                        selectedItems: selectedColors,
                        onConfirm: (items) {
                          setState(() => selectedColors = items);
                        },
                      ),
                      onRemove: (item) {
                        setState(() => selectedColors.remove(item));
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Products Material - Multi-select
                    _buildLabel("Products Material"),
                    _buildMultiSelectSection(
                      selectedItems: selectedMaterials,
                      onAddTap: () => _showMultiSelectBottomSheet(
                        title: "Select Materials",
                        items: materialList,
                        selectedItems: selectedMaterials,
                        onConfirm: (items) {
                          setState(() => selectedMaterials = items);
                        },
                      ),
                      onRemove: (item) {
                        setState(() => selectedMaterials.remove(item));
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Sizes - Multi-select
                    _buildLabel("Sizes"),
                    _buildMultiSelectSection(
                      selectedItems: selectedSizes,
                      onAddTap: () => _showMultiSelectBottomSheet(
                        title: "Select Sizes",
                        items: sizeList,
                        selectedItems: selectedSizes,
                        onConfirm: (items) {
                          setState(() => selectedSizes = items);
                        },
                      ),
                      onRemove: (item) {
                        setState(() => selectedSizes.remove(item));
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Brand Names and Price type - Side by side
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Brand Names"),
                              _buildSmallDropdownField(
                                value: selectedBrandName,
                                hintText: "Select",
                                onTap: () => _showSelectionBottomSheet(
                                  title: "Brand Names",
                                  items: brandNamesList,
                                  selectedValue: selectedBrandName,
                                  onSelect: (value) {
                                    setState(() => selectedBrandName = value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Price type"),
                              _buildSmallDropdownField(
                                value: selectedPriceType,
                                hintText: "Select",
                                onTap: () => _showSelectionBottomSheet(
                                  title: "Price type",
                                  items: priceTypeList,
                                  selectedValue: selectedPriceType,
                                  onSelect: (value) {
                                    setState(() => selectedPriceType = value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Purchase price and Offer Price - Side by side
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Purchase price"),
                              _buildTextField(
                                controller: purchasePriceCtrl,
                                hintText: "Write here",
                                keyboardType: TextInputType.number,
                                prefix: "\$ ",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Offer Price"),
                              _buildTextField(
                                controller: offerPriceCtrl,
                                hintText: "Write here",
                                keyboardType: TextInputType.number,
                                prefix: "\$ ",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Upload Images
                    _buildLabel("Upload Images"),
                    GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Assets.icons.arrowTop.svg(
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),

                    // Image preview
                    if (_images.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: SizedBox(
                          height: 70.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8.w),
                                    width: 70.h,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.file(
                                        _images[index],
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 12,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: EdgeInsets.all(2.r),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),

          // Save and Continue button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: CustomButton(
              title: "Save and Continue",
              onpress: () {
                // Handle save
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: text,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? prefix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade400,
          ),
          prefixText: prefix,
          prefixStyle: TextStyle(fontSize: 14.sp, color: Colors.black87),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    String? value,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: value ?? hintText,
              fontSize: 14.sp,
              color: value != null ? Colors.black87 : Colors.grey.shade400,
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallDropdownField({
    String? value,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: value ?? hintText,
                fontSize: 14.sp,
                color: value != null ? Colors.black87 : Colors.grey.shade400,
                maxline: 1,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelectSection({
    required List<String> selectedItems,
    required VoidCallback onAddTap,
    required Function(String) onRemove,
  }) {
    return Column(
      children: [
        // Show selected items with remove option
        ...selectedItems.map((item) => _buildSelectedItemTile(
              item: item,
              onRemove: () => onRemove(item),
            )),
        // Add more button
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Select",
                  fontSize: 14.sp,
                  color: Colors.grey.shade400,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedItemTile({
    required String item,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: item,
            fontSize: 14.sp,
            color: Colors.black87,
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 1.5),
              ),
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionBottomSheet({
    required String title,
    required List<String> items,
    String? selectedValue,
    required Function(String) onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: title,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(height: 16.h),
              ...items.map((item) => GestureDetector(
                    onTap: () {
                      onSelect(item);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: item,
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                          if (selectedValue == item)
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  void _showMultiSelectBottomSheet({
    required String title,
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onConfirm,
  }) {
    List<String> tempSelected = List.from(selectedItems);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(20.w),
              constraints: BoxConstraints(maxHeight: 500.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: title,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  SizedBox(height: 16.h),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = tempSelected.contains(item);
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              if (isSelected) {
                                tempSelected.remove(item);
                              } else {
                                tempSelected.add(item);
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: item,
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                                Container(
                                  padding: EdgeInsets.all(2.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    size: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: "Confirm",
                      onpress: () {
                        onConfirm(tempSelected);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null) {
      final newImages = picked.map((x) => File(x.path)).toList();
      setState(() {
        final remaining = 5 - _images.length;
        _images.addAll(newImages.take(remaining));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }
}
