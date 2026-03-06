import 'dart:io';
import 'package:danceattix/helper/photo_picker_helper.dart';
import 'package:danceattix/models/category_model_data.dart';
import 'package:danceattix/models/product_model_data.dart';
import 'package:danceattix/services/api_client.dart';
import 'package:danceattix/services/api_urls.dart';
import 'package:danceattix/views/widgets/custom_tost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> kSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'];

const String kIdImageList = 'image_list';
const String kIdColorList = 'color_list';
const String kIdTotalStock = 'total_stock';

String kIdAccordion(String hex) => 'accordion_$hex';

String kIdSizes(String hex) => 'sizes_$hex';

String kIdStock(String hex, String size) => 'stock_${hex}_$size';

class AddProductController extends GetxController {
  // ── State ────────────────────────────────────────────────────────────────
  final List<File> images = [];
  final List<String> imageUrls = [];
  final List<Color?> pickedColors = [];
  int? pickerIndex;
  String? expandedHex;

  final Map<String, Set<String>> colorSizes = {};
  final Map<String, TextEditingController> stock = {};

  // hex → colorId  (color API থেকে)
  final Map<String, int> colorIdMap = {};

  // sizeName → sizeId  (size API থেকে)
  final Map<String, int> sizeIdMap = {};

  // ── Helpers ──────────────────────────────────────────────────────────────

  String hex(Color c) => c.value.toRadixString(16).substring(2).toUpperCase();

  Color? colorAt(int i) =>
      (i >= 0 && i < pickedColors.length) ? pickedColors[i] : null;

  TextEditingController ctrl(String hex, String size) =>
      stock.putIfAbsent('${hex}_$size', () => TextEditingController(text: '0'));

  int totalStock() =>
      stock.values.fold(0, (s, c) => s + (int.tryParse(c.text) ?? 0));

  int colorStock(String hex) => stock.entries
      .where((e) => e.key.startsWith('${hex}_'))
      .fold(0, (s, e) => s + (int.tryParse(e.value.text) ?? 0));

  List<ColorEntry> get colorEntries {
    final result = <ColorEntry>[];
    for (int i = 0; i < pickedColors.length; i++) {
      final c = pickedColors[i];
      if (c != null) {
        result.add(ColorEntry(color: c, imageIndex: i, hex: hex(c)));
      }
    }
    return result;
  }

  // ── Photo ─────────────────────────────────────────────────────────────────
  void addPhoto(BuildContext context) {
    PhotoPickerHelper.showPicker(
      context: context,
      onImagePicked: (file) async {
        final imageFile = File(file.path);
        // images.add(imageFile);
        // pickedColors.add(null);
        // update([kIdImageList, kIdColorList]);

        getImageURL(imageFile);
        },
    );
  }

  void removePhoto(int index) {
    if (index < 0 || index >= images.length) return;
    final c = pickedColors[index];
    if (c != null) _removeColorData(hex(c));
    images.removeAt(index);
    pickedColors.removeAt(index);

    if (pickerIndex == index) {
      pickerIndex = null;
    } else if (pickerIndex != null && pickerIndex! > index) {
      pickerIndex = pickerIndex! - 1;
    }
    update([kIdImageList, kIdColorList]);
  }

  void _removeColorData(String hexVal) {
    colorSizes.remove(hexVal);
    colorIdMap.remove(hexVal);
    final ks = stock.keys.where((k) => k.startsWith('${hexVal}_')).toList();
    for (final k in ks) {
      stock[k]?.dispose();
      stock.remove(k);
    }
  }

  // ── Color Picker ──────────────────────────────────────────────────────────

  void togglePickerMode(int index) {
    pickerIndex = pickerIndex == index ? null : index;
    update([kIdImageList]);
  }

  // ✅ Color select হলে → colorsCreate() API call
  void setColorForImage(int index, Color color) {
    pickedColors[index] = color;
    pickerIndex = null;
    update([kIdImageList, kIdColorList]);

    final hexVal = hex(color);
    if (!colorIdMap.containsKey(hexVal)) {
      colorsCreate(hexVal: hexVal);
    }
  }

  // ── Accordion ─────────────────────────────────────────────────────────────

  void toggleAccordion(String hexVal) {
    final prev = expandedHex;
    expandedHex = expandedHex == hexVal ? null : hexVal;
    update([if (prev != null) kIdAccordion(prev), kIdAccordion(hexVal)]);
  }

  // ── Sizes ─────────────────────────────────────────────────────────────────

  // ✅ Size select হলে → sizesCreate() API call
  void toggleSize(String hexVal, String size) {
    final s = colorSizes.putIfAbsent(hexVal, () => {});
    if (s.contains(size)) {
      // deselect করলে remove করো
      s.remove(size);
      final k = '${hexVal}_$size';
      stock[k]?.dispose();
      stock.remove(k);
      update([kIdSizes(hexVal), kIdTotalStock, kIdAccordion(hexVal)]);
    } else {
      // select করলে API call করো, তারপর add করো
      s.add(size);
      update([kIdSizes(hexVal), kIdTotalStock, kIdAccordion(hexVal)]);

      if (!sizeIdMap.containsKey(size)) {
        sizesCreate(sizeName: size);
      }
    }
  }

  void clearSizes(String hexVal) {
    for (final s in (colorSizes[hexVal]?.toList() ?? [])) {
      final k = '${hexVal}_$s';
      stock[k]?.dispose();
      stock.remove(k);
    }
    colorSizes[hexVal]?.clear();
    update([kIdSizes(hexVal), kIdTotalStock, kIdAccordion(hexVal)]);
  }

  // ── Stock ──────────────────────────────────────────────────────────────────

  void incrementStock(String hexVal, String size) {
    final c = ctrl(hexVal, size);
    c.text = ((int.tryParse(c.text) ?? 0) + 1).toString();
    update([kIdStock(hexVal, size), kIdTotalStock, kIdSizes(hexVal)]);
  }

  void decrementStock(String hexVal, String size) {
    final c = ctrl(hexVal, size);
    final val = int.tryParse(c.text) ?? 0;
    if (val > 0) {
      c.text = (val - 1).toString();
      update([kIdStock(hexVal, size), kIdTotalStock, kIdSizes(hexVal)]);
    }
  }

  void onStockChanged(String hexVal, String size) {
    update([kIdStock(hexVal, size), kIdTotalStock, kIdSizes(hexVal)]);
  }

  /// ======================== Products Add ===========================>

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  bool isLoadingAdd = false;
  int? categoryId;

  Future<void> productsAdd() async {
    isLoadingAdd = true;
    update();

    // ── Variants build ───────────────────────────────────────────
    final List<Map<String, dynamic>> variants = [];
    for (final entry in colorEntries) {
      final sizes = colorSizes[entry.hex] ?? {};
      for (final size in sizes) {
        final stockVal = int.tryParse(ctrl(entry.hex, size).text) ?? 0;
        variants.add({
          "colorId": colorIdMap[entry.hex], // ✅ color API থেকে পাওয়া id
          "sizeId": sizeIdMap[size], // ✅ size API থেকে পাওয়া id
          "unit": stockVal,
        });
      }
    }

    // ── Image URLs ───────────────────────────────────────────────
    final requestBody = {
      "product_name": productNameController.text.trim(),
      "description": descriptionController.text.trim(),
      "condition": conditionController.text.trim(),
      "brand": brandController.text.trim(),
      "price": priceController.text.trim(),
      "subCategoryId": categoryId.toString(),
      "is_negotiable": false,
      "variants": variants,
      "images": imageUrls,
    };

    final response = await ApiClient.postData(ApiUrls.productsAdd, requestBody);
    final responseBody = response.body;

    if (response.statusCode == 201) {
      reset();
      Get.back();
      Get.back();
    } else {
      showToast(responseBody['message'] ?? 'Something went wrong');
    }

    isLoadingAdd = false;
    update();
  }

  void reset() {
    productNameController.clear();
    categoryController.clear();
    descriptionController.clear();
    priceController.clear();
    conditionController.clear();
    brandController.clear();
    images.clear();
    pickedColors.clear();
    colorSizes.clear();
    colorIdMap.clear();
    sizeIdMap.clear();
    for (final c in stock.values) {
      c.dispose();
    }
    stock.clear();
    pickerIndex = null;
    expandedHex = null;
    categoryId = null;
    update([kIdImageList, kIdColorList, kIdTotalStock]);
  }

  /// <======================= Category ===========================>

  bool isLoadingCategory = false;
  bool isLoadingCategoryMore = false;
  int categoryLimit = 10;
  int categoryPage = 1;
  int categoryTotalPage = -1;
  List<CategoryModelData> categoryData = [];

  Future<void> categoryGet({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      categoryData.clear();
      categoryPage = 1;
      categoryTotalPage = -1;
      isLoadingCategory = true;
      isLoadingCategoryMore = false;
      update();
    }

    final response = await ApiClient.getData(
      ApiUrls.categories(page: categoryPage, limit: categoryLimit),
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final List data = responseBody['data'] ?? [];
      categoryData.addAll(
        data.map((json) => CategoryModelData.fromJson(json)).toList(),
      );
      categoryTotalPage =
          responseBody['pagination']?['totalPages'] ?? categoryTotalPage;
    } else {
      showToast(responseBody['message']);
    }

    isLoadingCategory = false;
    isLoadingCategoryMore = false;
    update();
  }

  void productsMore(String type) async {
    if (categoryPage < categoryTotalPage && !isLoadingCategoryMore) {
      categoryPage += 1;
      isLoadingCategoryMore = true;
      update();
      await categoryGet(isInitialLoad: false);
    }
  }

  /// <======================= Colors Create ===========================>

  bool isColorsLoading = false;

  Future<void> colorsCreate({required String hexVal}) async {
    isColorsLoading = true;
    update();

    final requestBody = {"name": hexVal, "image": "#$hexVal"};

    final response = await ApiClient.postData(ApiUrls.colors, requestBody);
    final responseBody = response.body;

    if (response.statusCode == 201) {
      final id = responseBody['id'] ?? responseBody['id'];
      if (id != null) {
        colorIdMap[hexVal] = id;
        debugPrint('✅ Color saved → hex: $hexVal | id: $id');
      }
    } else {
      showToast(responseBody['message'] ?? 'Color creation failed');
    }

    isColorsLoading = false;
    update();
  }

  /// <======================= Sizes Create ===========================>

  bool isSizeLoading = false;

  Future<void> sizesCreate({required String sizeName}) async {
    isSizeLoading = true;
    update();

    // size name থেকে type বের করো
    final sizeType = _getSizeType(sizeName);

    final requestBody = {"name": sizeName, "type": sizeType};

    final response = await ApiClient.postData(ApiUrls.sizes, requestBody);
    final responseBody = response.body;

    if (response.statusCode == 201) {
      final id = responseBody['id'] ?? responseBody['id'];
      if (id != null) {
        sizeIdMap[sizeName] = id;
        debugPrint('✅ Size saved → name: $sizeName | id: $id');
      }
    } else {
      showToast(responseBody['message'] ?? 'Size creation failed');
    }

    isSizeLoading = false;
    update();
  }



  Future<void> getImageURL( File imageFile) async {


    final response = await ApiClient.getDataRaw(ApiUrls.imageURL,headers: {'Content-Type': 'application/json'});
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final url = responseBody['data']?['url'] ?? responseBody['data']?['url'];
      final imageUrl = responseBody['data']?['key'] ?? responseBody['data']?['key'];
      if (url != null) {
        uploadImage(url: url, imageFile: imageFile);
        debugPrint('✅ image url : $url');
      }
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
        debugPrint('✅ image url : $imageUrls');
      }

    } else {
      //showToast(responseBody['message'] ?? 'Size creation failed');
      showToast('Image upload field please try again');

    }

  }

  bool isUploadImage = false;

  Future<void> uploadImage({required String url, required File imageFile}) async {

    isUploadImage = true;
    update();

    final response = await ApiClient.putBinaryToUrl(url, imageFile);

    if (response.statusCode == 200) {
      images.add(imageFile);
      pickedColors.add(null);
      update([kIdImageList, kIdColorList]);
      log.i('✅ Image uploaded successfully to: $url');
    } else {
      showToast('Image upload field please try again');
    }
    isUploadImage = false;
    update();
  }

  // size name থেকে type map করো
  String _getSizeType(String size) {
    const typeMap = {
      'XS': 'extra_small',
      'S': 'small',
      'M': 'medium',
      'L': 'large',
      'XL': 'extra_large',
      'XXL': 'double_extra_large',
      '3XL': 'triple_extra_large',
    };
    return typeMap[size] ?? size.toLowerCase();
  }

  @override
  void onClose() {
    for (final c in stock.values) {
      c.dispose();
    }
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    conditionController.dispose();
    categoryController.dispose();
    brandController.dispose();
    super.onClose();
  }
}
