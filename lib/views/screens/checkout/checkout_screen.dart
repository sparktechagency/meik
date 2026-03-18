import 'package:danceattix/controllers/checkout_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final int productId = Get.arguments as int;
  final controller = Get.find<CheckoutController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkout(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.cleanupCheckout();
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "Checkout",backAction: (){
          controller.cleanupCheckout();
          Get.back();
        },),
        body: GetBuilder<CheckoutController>(
          builder: (c) => _buildBody(context, c),
        ),
        bottomNavigationBar: GetBuilder<CheckoutController>(
          builder: (c) => _buildBottomBar(context, c),
        ),
      ),
    );
  }

  // ==================== Body ====================
  Widget _buildBody(BuildContext context, CheckoutController c) {
    // Loading state
    if (c.isLoadingCheckout) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (c.checkoutError != null || c.checkoutData?.product == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.lottie.emptyData.lottie(),
            CustomText(
              text: 'No Data Found',
              color: AppColors.hitTextColorA5A5A5,
              fontSize: 16.sp,
            ),
            SizedBox(height: 16.h),

            /// 🔄 Refresh Button
            CustomButton(
              fontSize: 14.sp,
              height: 34.h,
              width: 100.w,
              title: 'Refresh',
              onpress: () async {
                await controller.checkout(productId);
              },
            ),
          ],
        ),
      );
    }

    // Success state
    final product = c.checkoutData!.product!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// 🔥 Product Card
          _buildProductCard(product),

          const SizedBox(height: 18),

          /// 🔥 Color & Size Selection (Compact)
          _buildColorAndSizeSection(c),

          const SizedBox(height: 18),

          /// 🔥 Quantity Section
          _buildQuantitySection(c),

          const SizedBox(height: 18),

          /// 🔥 Price Breakdown
          _buildPriceSection(c),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==================== Product Card ====================
  Widget _buildProductCard(dynamic product) {
    final imageUrl = product.images?.isNotEmpty == true
        ? product.images!.first.image
        : null;
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Info Row
          Row(
            children: [
              CustomNetworkImage(
                borderRadius: BorderRadius.circular(12.r),
                width: 80.w,
                height: 80.h,
                imageUrl: imageUrl,
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName ?? 'Unknown Product',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.brand ?? 'Unknown Brand',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Condition: ${product.condition ?? 'Unknown'}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Seller Info (if available)
          if (product.user != null) ...[
            Divider(color: Colors.grey.shade100),
            SizedBox(height: 4.h),
            Row(
              children: [
                //  if(product.user?.image != null)
                CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  width: 44.w,
                  height: 44.h,
                  imageUrl: product.user?.image ?? 'N/A',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.user?.firstName ?? ''} ${product.user?.lastName ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        product.user?.address ?? 'Location not available',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ==================== Color & Size Section (Combined) ====================
  Widget _buildColorAndSizeSection(CheckoutController c) {
    final isColorAutoSelected = c.colors.length == 1;
    final isSizeAutoSelected = c.sizes.length == 1;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Color',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (isColorAutoSelected)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          'Auto',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (c.selectedColorId != null)
                Text(
                  _getColorName(c),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (c.colors.isEmpty)
            Center(
              child: Text(
                'No colors available',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            )
          else
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: c.colors.map((color) {
                final colorId = color?.id;
                final isSelected = c.selectedColorId == colorId;
                final isAvailable = c.isColorAvailable(colorId ?? -1);

                return GestureDetector(
                  onTap: isAvailable
                      ? () => c.selectColor(colorId!)
                      : () => showToast('This color is not available'),
                  child: Tooltip(
                    message: color?.name ?? 'Unknown color',
                    child: Opacity(
                      opacity: isAvailable ? 1.0 : 0.35,
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Color(c.parseColorHex(color?.image)),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.black87
                                : Colors.grey.shade300,
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: isSelected
                            ? Center(
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                            : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 14),
          Divider(color: Colors.grey.shade100, height: 1),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Size',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (isSizeAutoSelected)
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          'Auto',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (c.selectedSizeId != null)
                Text(
                  _getSizeName(c),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (c.sizes.isEmpty)
            Center(
              child: Text(
                'No sizes available',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filterSizes(c.sizes).map((size) {
                final sizeId = size?.id;
                final isSelected = c.selectedSizeId == sizeId;
                final isAvailable = c.isSizeAvailable(sizeId ?? -1);

                return GestureDetector(
                  onTap: isAvailable
                      ? () => c.selectSize(sizeId!)
                      : () => showToast('This size is not available'),
                  child: Tooltip(
                    message: 'Size: ${size?.name}',
                    child: Opacity(
                      opacity: isAvailable ? 1.0 : 0.35,
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.black87
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black87
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Text(
                          size?.name ?? 'Unknown',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 13,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  /// Filter sizes to show only M, L, XL
  List<dynamic> _filterSizes(List<dynamic> sizes) {
    final validSizes = ['M', 'L', 'XL', 'XXL'];
    return sizes.where((size) {
      final sizeName = size?.name?.toUpperCase() ?? '';
      return validSizes.contains(sizeName);
    }).toList();
  }

  /// Get selected color name
  String _getColorName(CheckoutController c) {
    try {
      return c.colors
          .firstWhere((e) => e?.id == c.selectedColorId, orElse: () => null)
          ?.name ??
          '';
    } catch (e) {
      return '';
    }
  }

  /// Get selected size name
  String _getSizeName(CheckoutController c) {
    try {
      return c.sizes
          .firstWhere((e) => e?.id == c.selectedSizeId, orElse: () => null)
          ?.name ??
          '';
    } catch (e) {
      return '';
    }
  }

  // ==================== Quantity Section ====================
  Widget _buildQuantitySection(CheckoutController c) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                'Max: ${c.maxQuantity}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: c.quantity > 1 ? c.decrementQty : null,
                  icon: const Icon(Icons.remove),
                  iconSize: 18,
                  splashRadius: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '${c.quantity}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: c.quantity < c.maxQuantity ? c.incrementQty : null,
                  icon: const Icon(Icons.add),
                  iconSize: 18,
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Price Section ====================
  Widget _buildPriceSection(CheckoutController c) {
    final isLoading = c.isLoadingPreNext;
    final preview = c.previewData;
    final fallback = c.checkoutData;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          if (isLoading)
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: CupertinoActivityIndicator(),
              ),
            )
          else if (c.previewError != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.shade400,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    c.previewError!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red.shade600, fontSize: 14),
                  ),
                ],
              ),
            )
          else ...[
              _priceRow('Base Price', preview?.basePrice ?? fallback?.price),
              const SizedBox(height: 10),
              _priceRow(
                'Protection Fee',
                preview?.protectionFee ?? fallback?.protectionFee,
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade300, height: 1),
              const SizedBox(height: 10),
              _priceRow(
                'Total',
                preview?.finalPrice ?? fallback?.total,
                isBold: true,
                fontSize: 17,
              ),
            ],
        ],
      ),
    );
  }

  /// Price row widget
  Widget _priceRow(
      String title,
      dynamic value, {
        bool isBold = false,
        double fontSize = 14,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            fontSize: fontSize,
            letterSpacing: 0.3,
          ),
        ),
        Text(
          controller.formatPrice(value),
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: fontSize,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // ==================== Bottom Bar ====================
  Widget _buildBottomBar(BuildContext context, CheckoutController c) {
    final total = c.previewData?.finalPrice ?? c.checkoutData?.total ?? 0;
    final isLoading = c.isLoadingPreNext || c.isLoadingCheckout;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.formatPrice(total),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CustomButton(
                onpress: () => c.proceedToPayment(),
                title: "Continue",
              ),
            ),
          ),
        ],
      ),
    );
  }
}