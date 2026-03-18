import 'package:danceattix/models/checkout_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  // ==================== State ====================
  bool isLoadingCheckout = false;
  bool isLoadingPreNext = false;

  CheckoutModelData? checkoutData;
  CheckoutPreviewModel? previewData;

  String? checkoutError;
  String? previewError;

  // ==================== Selection State ====================
  int quantity = 1;
  int? selectedColorId;
  int? selectedSizeId;

  // ==================== Getters ====================

  /// Get selected variant ID based on color and size selection
  int? get selectedVariantId {
    final variants = checkoutData?.product?.variants ?? [];

    if (selectedColorId == null || selectedSizeId == null) return null;

    final match = variants.firstWhereOrNull((v) =>
    v.colorId == selectedColorId && v.sizeId == selectedSizeId);

    return match?.id;
  }

  /// Get max quantity for selected variant
  int get maxQuantity {
    final variants = checkoutData?.product?.variants ?? [];
    final variant = variants.firstWhereOrNull((v) => v.id == selectedVariantId);
    return variant?.unit ?? 1;
  }

  /// Get all unique colors from variants
  List<dynamic> get colors {
    final variants = checkoutData?.product?.variants ?? [];
    final colorMap = <int, dynamic>{};

    for (var variant in variants) {
      if (variant.color != null && variant.colorId != null) {
        colorMap[variant.colorId!] = variant.color;
      }
    }

    return colorMap.values.toList();
  }

  /// Get all unique sizes from variants
  List<dynamic> get sizes {
    final variants = checkoutData?.product?.variants ?? [];
    final sizeMap = <int, dynamic>{};

    for (var variant in variants) {
      if (variant.size != null && variant.sizeId != null) {
        sizeMap[variant.sizeId!] = variant.size;
      }
    }

    return sizeMap.values.toList();
  }

  /// Get available sizes for selected color
  List<int> get availableSizesForColor {
    if (selectedColorId == null) return [];

    final variants = checkoutData?.product?.variants ?? [];
    return variants
        .where((v) => v.colorId == selectedColorId)
        .map((v) => v.sizeId!)
        .toSet()
        .toList();
  }

  /// Get available colors for selected size
  List<int> get availableColorsForSize {
    if (selectedSizeId == null) return [];

    final variants = checkoutData?.product?.variants ?? [];
    return variants
        .where((v) => v.sizeId == selectedSizeId)
        .map((v) => v.colorId!)
        .toSet()
        .toList();
  }

  /// Check if color is available for current size selection
  bool isColorAvailable(int colorId) {
    if (selectedSizeId == null) return true; // All colors available if size not selected
    return availableColorsForSize.contains(colorId);
  }

  /// Check if size is available for current color selection
  bool isSizeAvailable(int sizeId) {
    if (selectedColorId == null) return true; // All sizes available if color not selected
    return availableSizesForColor.contains(sizeId);
  }

  /// Validation
  bool get isVariantSelected => selectedVariantId != null;

  bool get isCheckoutValid {
    return checkoutData?.product != null && isVariantSelected;
  }

  String? get validationError {
    if (!isVariantSelected) return "Please select color and size";
    return null;
  }

  // ==================== Checkout =================
  Future<void> checkout(int productId) async {
    checkoutError = null;
    isLoadingCheckout = true;
    update();

    try {
      final res = await ApiClient.getData(ApiUrls.checkout(productId));

      if (res.statusCode == 200) {
        checkoutData = CheckoutModelData.fromJson(res.body['data']);
        checkoutError = null;

        // Auto-select single color if only one exists
        if (colors.length == 1 && selectedColorId == null) {
          selectedColorId = colors.first?.id;
        }

        // Auto-select single size if only one exists
        if (sizes.length == 1 && selectedSizeId == null) {
          selectedSizeId = sizes.first?.id;
        }

        // If both color and size are auto-selected, fetch preview after a short delay
        if (isVariantSelected) {
          Future.delayed(const Duration(milliseconds: 500), () => preNext());
        }
      } else {
        checkoutError = res.body['message'] ?? 'Failed to load checkout data';
        showToast(checkoutError!);
      }
    } catch (e) {
      checkoutError = 'Network error. Please try again.';
      showToast(checkoutError!);
    }

    isLoadingCheckout = false;
    update();
  }

  /// Retry checkout
  Future<void> retryCheckout(int productId) async {
    await checkout(productId);
  }

  // ==================== Variant Selection =================

  void selectColor(int colorId) {
    selectedColorId = colorId;

    // Reset size if not available for this color
    if (selectedSizeId != null && !isSizeAvailable(selectedSizeId!)) {
      selectedSizeId = null;
    }

    _updatePreview();
  }

  void selectSize(int sizeId) {
    selectedSizeId = sizeId;

    // Reset color if not available for this size
    if (selectedColorId != null && !isColorAvailable(selectedColorId!)) {
      selectedColorId = null;
    }

    _updatePreview();
  }

  void _updatePreview() {
    if (isVariantSelected) {
      preNext();
    }
    update();
  }

  // ==================== Quantity =================

  void incrementQty() {
    if (quantity < maxQuantity) {
      quantity++;
      preNext();
      update();
    } else {
      showToast("Maximum quantity (${maxQuantity}) reached");
    }
  }

  void decrementQty() {
    if (quantity > 1) {
      quantity--;
      preNext();
      update();
    }
  }

  /// Reset quantity to 1
  void resetQuantity() {
    quantity = 1;
    update();
  }

  // ==================== Preview/Next =================

  Future<void> preNext() async {
    final product = checkoutData?.product;

    if (product == null || !isVariantSelected) {
      return;
    }

    previewError = null;
    isLoadingPreNext = true;
    update();

    try {
      final body = {
        "productId": product.id,
        "variantId": selectedVariantId,
        "quantity": quantity,
      };

      final res = await ApiClient.postData(ApiUrls.preNext, body);

      if (res.statusCode == 201) {
        previewData = CheckoutPreviewModel.fromJson(res.body['data']);
        previewError = null;
      } else {
        previewError = res.body['message'] ?? 'Failed to calculate price';
        showToast(previewError!);
      }
    } catch (e) {
      previewError = 'Network error calculating price';
      showToast(previewError!);
    }

    isLoadingPreNext = false;
    update();
  }

  /// Proceed to payment
  void proceedToPayment() {
    final error = validationError;

    if (error != null) {
      showToast(error);
      return;
    }

    final total = previewData?.finalPrice ?? checkoutData?.total ?? 0;

    Get.toNamed('/payment', arguments: {
      'variantId': selectedVariantId,
      'quantity': quantity,
      'total': total,
      'productId': checkoutData?.product?.id,
      'productName': checkoutData?.product?.productName,
      'colorId': selectedColorId,
      'sizeId': selectedSizeId,
    });
  }

  // ==================== Helpers =================

  /// Get color display value safely
  String getColorHex(dynamic color) {
    try {
      if (color == null) return '#CCCCCC';

      String hexString = color.image?.toString() ?? '#CCCCCC';
      if (!hexString.startsWith('#')) {
        hexString = '#$hexString';
      }
      return hexString;
    } catch (e) {
      return '#CCCCCC';
    }
  }

  /// Parse color hex to Color object safely
  int parseColorHex(String? hexColor) {
    try {
      if (hexColor == null || hexColor.isEmpty) return 0xFFCCCCCC;

      String cleanHex = hexColor.replaceFirst('#', '');
      if (cleanHex.length != 6) return 0xFFCCCCCC;

      return int.parse('0xFF$cleanHex');
    } catch (e) {
      return 0xFFCCCCCC; // Fallback grey color
    }
  }

  /// Format price
  String formatPrice(dynamic price) {
    double value = 0;

    if (price is double) value = price;
    if (price is int) value = price.toDouble();
    if (price is String) value = double.tryParse(price) ?? 0;

    return '\$${value.toStringAsFixed(2)}';
  }

  // ==================== Cleanup =================

  /// Clean up state when leaving checkout screen
  void cleanupCheckout() {
    selectedColorId = null;
    selectedSizeId = null;
    quantity = 1;
    checkoutData = null;
    previewData = null;
    checkoutError = null;
    previewError = null;
    isLoadingCheckout = false;
    isLoadingPreNext = false;
    update();
  }

  @override
  void onClose() {
    cleanupCheckout();
    super.onClose();
  }
}