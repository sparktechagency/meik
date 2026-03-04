import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  /// <======================= products ===========================>

  bool isLoadingProduct = false;
  bool isLoadingProductMore = false;
  int productLimit = 10;
  int productPage = 1;
  int productTotalPage = -1;
  int totalProduct = 0;
  List<ProductModelData> productsData = [];

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


  void clearFilters(){
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
    bool isInitialLoad = true,
  }) async {
    if (isInitialLoad) {
      productsData.clear();
      productPage = 1;
      productTotalPage = -1;
      isLoadingProduct = true;
      isLoadingProductMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.products(
        page: productPage,
        limit: productLimit,
        term: selectedProductFor,
        category: selectedCategory,
        price: '$minPrice-$maxPrice',
        size: selectedSizes,
        type: type,
      ),
    );

    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];

      final product = data
          .map((json) => ProductModelData.fromJson(json))
          .toList();

      productsData.addAll(product);
      productTotalPage = responseBody['pagination']?['totalPages'] ?? productTotalPage;
      totalProduct = responseBody['pagination']?['total'] ?? totalProduct;
    } else {
      showToast(responseBody['message']);
    }

    isLoadingProduct = false;
    isLoadingProductMore = false;
    update();
  }

  void productsMore(String type) async {
    debugPrint('============> Page $productPage');

    if (productPage < productTotalPage && !isLoadingProductMore) {
      productPage += 1;
      isLoadingProductMore = true;
      update();

      await productsGet(type: type, isInitialLoad: false);
      debugPrint(
        '============> Page++ $productPage \n=============> totalPage $productTotalPage',
      );
    }
  }
}
