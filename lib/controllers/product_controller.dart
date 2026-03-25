import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    productsGet();
    productsGet(type: 'own', status: 'available');
    productsGet(type: 'own', status: 'pending');
  }

  /// <======================= products ===========================>

  bool isLoadingProduct = false;
  bool isLoadingProductMore = false;
  int productLimit = 10;
  int productPage = 1;
  int productTotalPage = -1;
  int totalProduct = 0;
  List<ProductModelData> productsData = [];
  List<ProductModelData> searchResults = [];
  List<ProductModelData> listedProductsData = [];
  List<ProductModelData> pendingProductsData = [];

  // Filter options
  List<String> conditions = ["Brand new", "Used"];
  String selectedCondition = "";

  List<String> productFor = ["Man", "Women", "Kids"];
  String selectedProductFor = "";

  List<String> brands = ["Lotto", "Zara", "Puma", "Levi's"];
  String selectedBrand = "";

  List<String> categories = ["Dress", "Shoes", "Clock"];
  String selectedCategory = "";

  List<String> sizes = ["S", "M", "L", "XL", "XXL", "XXXL"];
  String selectedSizes = '';

  double minPrice = 10;
  double maxPrice = 1000;

  void clearFilters() {
    selectedCondition = '';
    selectedProductFor = '';
    selectedBrand = '';
    selectedCategory = '';
    selectedSizes = '';
    minPrice = 10;
    maxPrice = 1000;
    update();
    productsGet();
  }

  Future<void> productsGet({
    String type = '',
    String term = '',
    String status = '',
    bool isInitialLoad = true,
  }) async {
    final bool isSearch = term.isNotEmpty;

    try {
      if (isInitialLoad) {
        if (isSearch) {
          // Search: only clear searchResults, no loading spinner
          searchResults.clear();
        } else if (status == 'available' && type == 'own') {
          listedProductsData.clear();
          isLoadingProduct = true;
          isLoadingProductMore = false;
          productPage = 1;
          productTotalPage = -1;
          update();
        } else if (status == 'pending' && type == 'own') {
          pendingProductsData.clear();
          isLoadingProduct = true;
          isLoadingProductMore = false;
          productPage = 1;
          productTotalPage = -1;
          update();
        } else {
          productsData.clear();
          isLoadingProduct = true;
          isLoadingProductMore = false;
          productPage = 1;
          productTotalPage = -1;
          update();
        }
      }

      final response = await ApiClient.getData(
        ApiUrls.products(
          page: productPage,
          limit: productLimit,
          term: term,
          category: selectedCategory,
          price: '$minPrice-$maxPrice',
          size: selectedSizes,
          type: type,
          status: status,
        ),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];
        final products = data
            .map((json) => ProductModelData.fromJson(json))
            .toList();

        if (isSearch) {
          searchResults.addAll(products);
        } else if (status == 'available') {
          listedProductsData.addAll(products);
        } else if (status == 'pending') {
          pendingProductsData.addAll(products);
        } else {
          productsData.addAll(products);
        }

        // FIX: only update pagination when not a search call
        if (!isSearch) {
          productTotalPage =
              responseBody['pagination']?['totalPages'] ?? productTotalPage;
          totalProduct = responseBody['pagination']?['total'] ?? totalProduct;
        }
      }
    } catch (e) {
      debugPrint('productsGet error: $e');
    } finally {
      if (!isSearch) {
        isLoadingProduct = false;
        isLoadingProductMore = false;
      }
      update();
    }
  }

  // FIX: accept status so pagination works correctly for all list types
  Future<void> productsMore(String type, {String status = ''}) async {
    debugPrint('============> Page $productPage');

    if (productPage < productTotalPage && !isLoadingProductMore) {
      productPage += 1;
      isLoadingProductMore = true;
      update();

      await productsGet(type: type, status: status, isInitialLoad: false);

      debugPrint(
        '============> Page++ $productPage \n=============> totalPage $productTotalPage',
      );
    }
  }
}
