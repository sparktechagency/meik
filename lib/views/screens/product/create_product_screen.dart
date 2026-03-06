
import 'package:danceattix/controllers/add_product_controller.dart';
import 'package:danceattix/core/config/app_route.dart';
import 'package:danceattix/helper/menu_show_helper.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AddProductController _controller = Get.find<AddProductController>();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.categoryGet();
    });
    super.initState();
  }

  void showMenu(
      TapDownDetails details,
      List<String> options,
      TextEditingController controller,
      BuildContext context,
      ) async {
    final selected = await MenuShowHelper.showCustomMenu(
      context: context,
      details: details,
      options: options,
    );
    if (selected != null) {
      controller.text = selected;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Create Product'),
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              SizedBox(height: 6.h),
              CustomTextField(
                borderRadio: 16.r,
                filColor: Colors.grey.shade100,
                borderColor: Colors.transparent,
                labelText: 'Product Name.',
                hintText: 'Add Product Name',
                controller: _controller.productNameController,
              ),



              CustomTextField(
                minLines: 3,
                borderRadio: 16.r,
                filColor: Colors.grey.shade100,
                borderColor: Colors.transparent,
                labelText: 'Description',
                hintText: 'Add Description',
                controller: _controller.descriptionController,
              ),

              GetBuilder<AddProductController>(
                builder: (controller) {
                  return GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      final selected = await MenuShowHelper.showCustomMenu(
                        context: context,
                        details: details,
                        options: controller.categoryData
                            .map((e) => e.category?.name ?? '')
                            .toList(),
                      );
                      if (selected != null) {
                        _controller.categoryController.text = selected;

                        // ✅ selected name দিয়ে categoryId খুঁজে নাও
                        final matched = controller.categoryData.firstWhereOrNull(
                              (e) => e.category?.name == selected,
                        );
                        if (matched != null) {
                          _controller.categoryId = matched.category?.id;
                        }
                        debugPrint('============>>${_controller.categoryId}');
                        setState(() {});
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        borderRadio: 16.r,
                        filColor: Colors.grey.shade100,
                        borderColor: Colors.transparent,
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        labelText: 'Category',
                        hintText: 'category',
                        controller: _controller.categoryController,
                      ),
                    ),
                  );
                },
              ),

              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  showMenu(
                    details,
                    MenuShowHelper.conditionList,
                    _controller.conditionController,
                    context,
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    borderRadio: 16.r,
                    filColor: Colors.grey.shade100,
                    borderColor: Colors.transparent,
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: 'Condition',
                    hintText: 'condition',
                    controller: _controller.conditionController,
                  ),
                ),
              ),

              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  showMenu(
                    details,
                    MenuShowHelper.brand,
                    _controller.brandController,
                    context,
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    borderRadio: 16.r,
                    filColor: Colors.grey.shade100,
                    borderColor: Colors.transparent,
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: 'Brand',
                    hintText: 'brand',
                    controller: _controller.brandController,
                  ),
                ),
              ),


              CustomTextField(
                borderRadio: 16.r,
                filColor: Colors.grey.shade100,
                borderColor: Colors.transparent,
                keyboardType: TextInputType.number,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.monetization_on_outlined,color: Colors.grey,),
                ),
                labelText: 'Price',
                hintText: 'Add your price here',
                controller: _controller.priceController,
              ),

              SizedBox(height: 16.h),

              CustomButton(
                onpress: () {
                  if (_globalKey.currentState!.validate()) {
                    Get.toNamed(AppRoutes.addProductVariantScreen);
                  }
                },
                title: 'Next',
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.productNameController.dispose();
    // _controller.descriptionController.dispose();
    // _controller.priceController.dispose();
    // _controller.categoryController.dispose();
    // _controller.discountController.dispose();
    // _controller.discountDaysController.dispose();
    super.dispose();
  }
}