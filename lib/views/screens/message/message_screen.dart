import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/controllers/offer_controller.dart';
import 'package:danceattix/controllers/socket_chat_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/models/inbox_model_data.dart';
import 'package:danceattix/views/widgets/chat_card.dart';
import 'package:danceattix/views/widgets/custom_list_tile.dart';
import 'package:danceattix/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final String conversationID = Get.arguments as String;
  final ChatsController _chatController = Get.find<ChatsController>();
  final SocketChatController _socketChatController = Get.find<SocketChatController>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController offerPriceCtrl = TextEditingController();

  @override
  void initState() {
    _socketChatController.listenMessage(conversationID);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatController.inboxGet(conID: conversationID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0.w,
      appBar: CustomAppBar(
        titleWidget: GetBuilder<ChatsController>(
          builder: (controller) {
            final conversation = controller.inboxData?.conversation;
            if (conversation == null) return const SizedBox();

            return CustomListTile(
              contentPaddingHorizontal: 0,
              imageRadius: 24.r,
              image: conversation.image ?? 'N/A',
              title: conversation.name ?? 'N/A',
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ChatsController>(
              builder: (controller) {
                final messages = controller.inboxData?.messages;

                if (messages == null || messages.isEmpty) {
                  return const Center(
                    child: CustomText(text:
                      'No messages yet',
                      color: Colors.grey,
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 8.w,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    /// ✅ Null-safe sender check
                    final isMe =
                        message.senderId ==
                        Get.find<UserController>().userData?.id;

                    /// ✅ Null-safe attachments
                    final List<String> images = message.attachments
                        ?.map((e) => e.fileUrl ?? '')
                        .where((url) => url.isNotEmpty)
                        .toList() ??
                        [];

                    return ChatBubbleMessage(
                      offer: message.offer,
                      images: images,
                      text: message.msg,
                      time: message.createdAt ?? '',
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageSender(),
        ],
      ),
    );
  }

  Widget _buildMessageSender() {
    return GetBuilder<ChatsController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              // GestureDetector(
              //   onTap: (){
              //
              //   },
              //     child: Assets.icons.addImage.svg()),
              // SizedBox(width: 10.w),
              Expanded(
                child: CustomTextField(
                  borderRadio: 24.r,
                  contentPaddingVertical: 0,
                  borderColor: AppColors.primaryColor,
                  showShadow: false,
                  validator: (_) => null,
                  controller: _messageController,
                  hintText: 'Type message...',
                  suffixIcon: GetBuilder<SocketChatController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: (){
                          final text = _messageController.text.trim();
                          if (text.isEmpty) return;
                          controller.sendMessage(message: _messageController.text.trim(), conversationId: conversationID);

                          _messageController.clear();
                        },
                        child: Assets.icons.massegeSend.svg(),
                      );
                    }
                  ),
                ),
              ),
              if(controller.inboxData?.conversation?.product?.user?.id == Get.find<UserController>().userData?.id )...[
                SizedBox(width: 10.w),
                CustomButton(
                  borderRadius: 44.r,
                  width: 110.w,
                  title: 'Make offer',
                  onpress: () {
                    _showMakeOfferDialog(controller.inboxData?.conversation?.product);
                  },
                ),
              ],

            ],
          ),
        );
      }
    );
  }


  void _showMakeOfferDialog(Product? product) {
    final imageUrl = (product?.images?.isNotEmpty ?? false)
        ? '${product!.images!.first.image}'
        : '';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.bgColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 12.w),
                  CustomText(
                    text: "Make Offer",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Assets.icons.clean.svg(),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Product Info
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CustomNetworkImage(
                      imageUrl: imageUrl,
                      height: 60.h,
                      width: 60.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: product?.productName ?? '',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Price: \$ ${product?.price ?? 0.0}",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Offer Price Input
              CustomTextField(
                labelText: 'Offer your price',
                hintText: 'Enter price',
                filColor: Colors.grey.shade200,
                showShadow: false,
                borderRadio: 100.r,
                controller: offerPriceCtrl,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 24.h),

              // Make Offer Button
              GetBuilder<OfferController>(
                  builder: (controller) {
                    return CustomButton(
                      loading: controller.isLoadingSend,
                      title: "Make offer",
                      onpress: () {
                        if(offerPriceCtrl.text.isEmpty) return;
                        controller.send(product?.id ?? 0, double.parse(offerPriceCtrl.text));
                      },
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _socketChatController.removeListeners(conversationID);
    super.dispose();
  }

}
