import 'package:danceattix/controllers/checkout_controller.dart';
import 'package:danceattix/views/widgets/custom_app_bar.dart';
import 'package:danceattix/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: CustomAppBar(title: "Checkout"),
      body: GetBuilder<CheckoutController>(
        builder: (c) => _buildBody(context, c),
      ),
      bottomNavigationBar: GetBuilder<CheckoutController>(
        builder: (c) => _buildBottomBar(context, c),
      ),
    );
  }

  // ==================== Body ====================
  Widget _buildBody(BuildContext context, CheckoutController c) {
    // Loading state
    if (c.isLoadingCheckout) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state
    if (c.checkoutError != null || c.checkoutData?.product == null) {
      return _buildErrorState(context, c);
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Info Row
          Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildProductImage(product),
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
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: product.user?.image != null
                      ? NetworkImage(product.user!.image!)
                      : null,
                  child: product.user?.image == null
                      ? const Icon(Icons.person)
                      : null,
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

  /// Product Image with error handling
  Widget _buildProductImage(dynamic product) {
    final imageUrl = product.images?.isNotEmpty == true
        ? product.images!.first.image
        : null;

    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey.shade400,
        ),
      );
    }

    return Image.network(
      imageUrl,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.grey.shade400,
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
    );
  }

  // ==================== Color & Size Section (Combined) ====================
  Widget _buildColorAndSizeSection(CheckoutController c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Color',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
              if (c.selectedColorId != null)
                Text(
                  _getColorName(c),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (c.colors.isEmpty)
            Center(
              child: Text(
                'No colors available',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
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
                      : () => _showUnavailableMessage('This color is not available'),
                  child: Tooltip(
                    message: color?.name ?? 'Unknown color',
                    child: Opacity(
                      opacity: isAvailable ? 1.0 : 0.35,
                      child: Container(
                        width: 42,
                        height: 42,
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
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 14),

          // Size Section (M, L, XL only)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Size',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
              if (c.selectedSizeId != null)
                Text(
                  _getSizeName(c),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (c.sizes.isEmpty)
            Center(
              child: Text(
                'No sizes available',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
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
                      : () => _showUnavailableMessage('This size is not available'),
                  child: Tooltip(
                    message: 'Size: ${size?.name}',
                    child: Opacity(
                      opacity: isAvailable ? 1.0 : 0.35,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.black87
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
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
                            color: isSelected
                                ? Colors.white
                                : Colors.black,
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
    final validSizes = ['M', 'L', 'XL'];
    return sizes.where((size) {
      final sizeName = size?.name?.toUpperCase() ?? '';
      return validSizes.contains(sizeName);
    }).toList();
  }

  /// Get selected color name
  String _getColorName(CheckoutController c) {
    try {
      return c.colors.firstWhere((e) => e?.id == c.selectedColorId, orElse: () => null)?.name ?? '';
    } catch (e) {
      return '';
    }
  }

  /// Get selected size name
  String _getSizeName(CheckoutController c) {
    try {
      return c.sizes.firstWhere((e) => e?.id == c.selectedSizeId, orElse: () => null)?.name ?? '';
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
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Max: ${c.maxQuantity}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
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
                  onPressed:
                  c.quantity < c.maxQuantity ? c.incrementQty : null,
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
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
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
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else ...[
              _priceRow(
                'Base Price',
                preview?.basePrice ?? fallback?.price,
              ),
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
                onpress: () {},
                title: "Continue",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Error State ====================
  Widget _buildErrorState(BuildContext context, CheckoutController c) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Load Checkout',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              c.checkoutError ?? 'Unable to load product information',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => c.retryCheckout(productId),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== Helpers ====================
  void _showUnavailableMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange.shade600,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}