import 'package:danceattix/controllers/offer_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/helper/time_format_helper.dart';
import 'package:danceattix/models/inbox_model_data.dart';
import 'package:danceattix/views/widgets/custom_image_avatar.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatBubbleMessage extends StatelessWidget {
  final String time;
  final String? text;
  final Offer? offer;
  final List<String>? images;
  final bool isSeen;
  final bool isMe;
  final String status;
  final VoidCallback? onBuyNow;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    this.text,
    this.images,
    required this.isMe,
    this.isSeen = false,
    this.status = 'offline',
    this.offer,
    this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isMe) CustomImageAvatar(right: 8.w, radius: 15.r),
              Flexible(
                child: CustomContainer(
                  paddingAll: 10.r,
                  color: isMe ? Colors.white : Colors.white,
                  bottomRight: 10.r,
                  bottomLeft: 10.r,
                  topLeftRadius: isMe ? 10.r : 0,
                  topRightRadius: !isMe ? 10.r : 0,
                  child: _buildMessageContent(),
                ),
              ),
            ],
          ),
          //SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              CustomText(
                top: 3.h,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                text: TimeFormatHelper.timeFormat(DateTime.parse(time)),
                color: AppColors.hitTextColorA5A5A5,
                left: isMe ? 0 : 44.w,
                // right: isMe ? 10.w : 0,
              ),
              // SizedBox(width: 4.w),
              // _buildMessageStatusIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    final validImages = images?.where((e) => e.isNotEmpty).toList() ?? [];
    if (validImages.isNotEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = validImages.length == 1 ? 200.w : 140.w;
          return Wrap(
            spacing: 5.w,
            runSpacing: 5.h,
            children: validImages.map((url) {
              debugPrint('------------------- >>>$url');
              return SizedBox(
                width: imageSize,
                height: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CupertinoActivityIndicator());
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    }
    if (text?.isNotEmpty == true || offer != null) {
      final offerStatus = offer?.status;
      return GetBuilder<OfferController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                enableAutoTranslate: false,
                maxline: 10,
                fontSize: 14.sp,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: const Color(0xff1B1B1B),
                text: text!,
              ),

              if (offer != null) ...[
                SizedBox(height: 8.h),
                if (offerStatus == 'accepted' && !isMe)
                  _buildOfferButton(label: 'Buy now', onTap: onBuyNow ?? () {})
                else if (offerStatus == 'accepted' && isMe)
                  CustomText(
                    text: 'Offer accepted',
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  )
                else if (offerStatus == 'pending' && isMe)
                  CustomText(
                    text: 'Offer pending',
                    fontSize: 12.sp,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  )
                else if (offerStatus == 'pending' && !isMe)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOfferButton(
                        label: controller.isLoadingAccept ? 'Wait..' : 'Accept',
                        onTap: () {
                          controller.accept('${offer?.id ?? ''}');
                        },
                      ),
                      SizedBox(width: 8.w),
                      _buildOfferButton(
                        color: AppColors.errorColor,
                        label: controller.isLoadingReject ? 'Wait..' : 'Decline',
                        onTap: () {
                          controller.reject('${offer?.id ?? ''}');
                        },
                      ),
                    ],
                  )
                else if (offerStatus == 'rejected')
                  CustomText(
                    text: 'Offer rejected',
                    fontSize: 12.sp,
                    color: AppColors.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
              ],
            ],
          );
        },
      );
    }

    return const SizedBox();
  }

  Widget _buildOfferButton({
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CustomText(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
