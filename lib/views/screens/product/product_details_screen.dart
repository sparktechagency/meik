import 'package:danceattix/controllers/product_details_controller.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/models/product_details_model_data.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/screens/product/widgets/product_image_section.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:danceattix/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController offerPriceCtrl = TextEditingController();
   final ProductDetailsController _controller = Get.find<ProductDetailsController>();

  final int productId = Get.arguments as int;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.productDetails(productId);
    });
  }

  @override
  void dispose() {
    offerPriceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (ctrl) {
        final product = ctrl.productDetailsData;

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: ctrl.isLoadingDetails
              ? const Center(child: CircularProgressIndicator())
              : product == null
              ? const Center(child: Text("Product not found"))
              : _buildBody(product),
          bottomNavigationBar: product == null
              ? null
              : _buildBottomBar(product),
        );
      },
    );
  }

  Widget _buildBody(ProductDetailsModelData product) {
    // Build image list from API
    final List<String> images = product.images
        ?.map((img) => '${ApiUrls.baseUrl}/${img.image ?? ''}')
        .toList() ??
        [];

    // Unique colors
    final colors = <String>{};
    final sizes = <String>{};
    for (final v in product.variants ?? []) {
      if (v.color?.image != null) colors.add(v.color!.image!);
      if (v.size?.name != null) sizes.add(v.size!.name!);
    }

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 280.h,
            floating: false,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.bgColor,
            leading: IconButton(
              icon: Assets.icons.back.svg(height: 24.h, width: 24.w),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              // ❤️ Favourite Button
              GetBuilder<ProductDetailsController>(
                builder: (ctrl) {
                  final isFav = product.isFavorite ?? false;
                  return IconButton(
                    onPressed: ctrl.isLoadingFvrt
                        ? null
                        : () => ctrl.toggleFavourite(product.id!),
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Favorite Icon (always visible)
                        Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                          size: 26.sp,
                        ),
                        // Circular loader on top when loading
                        if (ctrl.isLoadingFvrt)
                          SizedBox(
                            height: 32.h,
                            width: 32.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: 8.w),
            ],
            flexibleSpace: ProductImageSection(
              images: images.isNotEmpty
                  ? images
                  : ['https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=600'],
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Title and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: product.productName ?? 'N/A',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "\$ ${product.price ?? 0}",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Product Tags
              _buildProductTags(product),

              SizedBox(height: 16.h),

              // Product Attributes
              _buildProductAttributes(product, sizes, colors),




              SizedBox(height: 20.h),

              // Description
              _buildDescriptionSection(product.description ?? ''),

              SizedBox(height: 20.h),


              // Seller Info
              _buildSellerInfo(product),
              SizedBox(height: 24.h),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(ProductDetailsModelData product) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
                  onpress: () => _showMakeOfferDialog(product),
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
              child: Assets.icons.message.svg(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTags(ProductDetailsModelData product) {
    final tags = [
      if (product.brand != null && product.brand!.isNotEmpty)
        {"label": "Brand", "value": product.brand!},
      if (product.condition != null && product.condition!.isNotEmpty)
        {"label": "Condition", "value": product.condition!},
      if (product.isNegotiable != null)
        {"label": "Price", "value": product.isNegotiable! ? "Negotiable" : "Fixed"},
    ];

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: tags.map((info) {
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

  Widget _buildProductAttributes(
      ProductDetailsModelData product,
      Set<String> sizes,
      Set<String> colors,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.condition != null)
          _buildAttributeRow("Condition", product.condition!),
        if (product.condition != null) SizedBox(height: 8.h),
        _buildAttributeRow(
          "Price type",
          (product.isNegotiable ?? false) ? "Negotiable" : "Fixed",
        ),
        if (sizes.isNotEmpty) SizedBox(height: 8.h),
        if (sizes.isNotEmpty)
          _buildAttributeRow("Sizes", sizes.join(", ")),
        if (colors.isNotEmpty) SizedBox(height: 8.h),
        if (colors.isNotEmpty)
          _buildAttributeRowWithColors("Colors", colors.toList()),
        if (product.buyerProtection != null) SizedBox(height: 8.h),
        if (product.buyerProtection != null)
          _buildAttributeRow(
            "Buyer Protection",
            "\$${product.buyerProtection!.toStringAsFixed(2)}",
          ),
      ],
    );
  }

  Widget _buildAttributeRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
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

  Widget _buildAttributeRowWithColors(String label, List<String> hexColors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.w,
            child: CustomText(
              text: "$label :",
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
          ),
          Wrap(
            spacing: 6.w,
            children: hexColors.map((hex) {
              Color? c;
              try {
                c = Color(int.parse('0xFF${hex.replaceAll('#', '')}'));
              } catch (_) {
                c = Colors.grey;
              }
              return Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerInfo(ProductDetailsModelData product) {
    final user = product.user;
    if (user == null) return const SizedBox.shrink();

    final imageUrl = user.image != null
        ? '${ApiUrls.baseUrl}/${user.image}'
        : null;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: imageUrl != null
                ? CustomNetworkImage(
              imageUrl: imageUrl,
              height: 48.h,
              width: 48.w,
            )
                : Container(
              height: 48.h,
              width: 48.w,
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: user.address ?? '',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          // Rating
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16.sp),
              SizedBox(width: 4.w),
              CustomText(
                text: "${user.rating ?? 0}",
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String description) {
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
          text: description.isNotEmpty ? description : "No description available.",
          fontSize: 12.sp,
          color: Colors.grey.shade600,
          maxline: 20,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  void _showMakeOfferDialog(ProductDetailsModelData product) {
    final imageUrl = (product.images?.isNotEmpty ?? false)
        ? '${ApiUrls.baseUrl}/${product.images!.first.image}'
        : '';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.bgColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 12.w),
                  CustomText(
                    text: "Make Offer",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Assets.icons.clean.svg(),
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
                      imageUrl: imageUrl,
                      height: 60.h,
                      width: 60.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: product.productName ?? '',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Price: \$ ${product.price ?? 0}",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Offer Price Input
              CustomTextField(
                labelText: 'Offer your price',
                hintText: 'Enter price',
                filColor: Colors.grey.shade200,
                showShadow: false,
                borderRadio: 100.r,
                controller: offerPriceCtrl,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 24.h),

              // Make Offer Button
              CustomButton(
                loaderIgnore: true,
                title: "Make offer",
                onpress: () {
                  Navigator.pop(context);
                  // TODO: submit offer API
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}