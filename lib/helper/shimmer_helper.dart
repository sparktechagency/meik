import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  ShimmerHelper._();

  static ShimmerHelper get instance => ShimmerHelper._();

  ///─── Public: Full Feed Shimmer ─────────────────────────────────────────────
  Widget showFeedShimmer() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStoryShimmer(),
          _buildSectionShimmer(),
          _buildSectionShimmer(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget showProductShimmer() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        childAspectRatio: 170.w / 263.h,
        crossAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) {
        return _buildProductCardShimmer();
      },
    );
  }

  // ─── Core shimmer animation wrapper ───────────────────────────────────────
  Widget _shimmerBox({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }

  // ─── Story Section Shimmer ─────────────────────────────────────────────────
  Widget _buildStoryShimmer() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(right: 14.w),
              child: Column(
                children: [
                  _shimmerBox(width: 62.w, height: 62.h, borderRadius: 16.r),
                  SizedBox(height: 6.h),
                  _shimmerBox(width: 50.w, height: 10.h, borderRadius: 4),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // ─── Horizontal Product Section Shimmer ───────────────────────────────────
  Widget _buildSectionShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _shimmerBox(width: 130.w, height: 16.h, borderRadius: 4),
              _shimmerBox(width: 60.w, height: 14.h, borderRadius: 4),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 263.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(4, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16.w : 10.w,
                    right: index == 3 ? 16.w : 0,
                  ),
                  child: _buildProductCardShimmer(),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget showMyProductShimmer() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemBuilder: (context, index) {
        return _buildMyProductCardShimmer();
      },
    );
  }

  Widget _buildMyProductCardShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(6.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            _shimmerBox(width: 102.w, height: 142.h, borderRadius: 8),
            SizedBox(width: 7.w),

            // Info shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  // Title
                  _shimmerBox(width: 120.w, height: 14.h, borderRadius: 4),
                  SizedBox(height: 10.h),
                  // Price
                  _shimmerBox(width: 80.w, height: 12.h, borderRadius: 4),
                  SizedBox(height: 10.h),
                  // Description line 1
                  _shimmerBox(width: double.infinity, height: 10.h, borderRadius: 4),
                  SizedBox(height: 5.h),
                  // Description line 2
                  _shimmerBox(width: double.infinity, height: 10.h, borderRadius: 4),
                  SizedBox(height: 5.h),
                  // Description line 3
                  _shimmerBox(width: 100.w, height: 10.h, borderRadius: 4),
                  SizedBox(height: 14.h),
                  // Boost button
                  _shimmerBox(width: 140.w, height: 30.h, borderRadius: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Single Product Card Shimmer (CustomProductCard এর exact copy) ─────────
  Widget _buildProductCardShimmer() {
    return Container(
      width: 170.w,
      height: 263.h,
      margin: EdgeInsets.only(bottom: 10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r), // card এর মতো 16.r
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image + Favorite icon (Stack) ──────────────────────────────────
          Stack(
            children: [
              // Image: top corners rounded, height 124.h
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: _shimmerBox(
                  width: double.infinity,
                  height: 124.h,
                  borderRadius: 0, // ClipRRect handles rounding
                ),
              ),
              // Favorite circle top-right
              Positioned(
                top: 8.h,
                right: 8.w,
                child: _shimmerBox(width: 30.w, height: 30.h, borderRadius: 15),
              ),
            ],
          ),

          // ── Info section ───────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (w600, 12sp)
                _shimmerBox(width: 110.w, height: 12.h, borderRadius: 4),
                SizedBox(height: 4.h),

                // Description (10sp)
                _shimmerBox(width: 90.w, height: 10.h, borderRadius: 4),
                SizedBox(height: 6.h),

                // Price (bold, 16sp)
                _shimmerBox(width: 55.w, height: 16.h, borderRadius: 4),
                SizedBox(height: 6.h),

                // Rating: 5 star icons + review count
                Row(
                  children: [
                    ...List.generate(
                      5,
                          (_) => Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: _shimmerBox(width: 14.w, height: 14.h, borderRadius: 3),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    _shimmerBox(width: 24.w, height: 10.h, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 10.h),

                // Buttons: [Buy Now (Expanded)] [Offer (Expanded)] [Message circle]
                Row(
                  children: [
                    Expanded(
                      child: _shimmerBox(
                        width: double.infinity,
                        height: 32.h,
                        borderRadius: 12,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: _shimmerBox(
                        width: double.infinity,
                        height: 32.h,
                        borderRadius: 12,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    // Message icon circle
                    _shimmerBox(width: 32.w, height: 32.h, borderRadius: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}