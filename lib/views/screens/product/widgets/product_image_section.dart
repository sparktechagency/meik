import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/widgets/cachanetwork_image.dart';
import 'package:danceattix/views/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageSection extends StatefulWidget {
  final List<String> images;

  const ProductImageSection({super.key, required this.images});

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          // 🔹 Main Image Slider
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CustomNetworkImage(
                imageUrl: widget.images[index],
               // height: 200.h,
                width: double.infinity,
              );
            },
          ),

          // 🔹 Thumbnail List
          if(widget.images.length > 1)
            Positioned(
              bottom: 24.h,
              right: 24.w,
              child: SizedBox(
                width: 30.w,
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.images.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final imageUrl = widget.images[index];
                    final isActive = index == currentIndex;

                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.w),
                        child: CustomContainer(
                          height: 30.h,
                          width: 30.w,
                          radiusAll: 4.r,
                          bordersColor:
                          isActive ? AppColors.dividerColor : Colors.transparent,
                          child: CustomNetworkImage(
                            imageUrl: imageUrl,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}