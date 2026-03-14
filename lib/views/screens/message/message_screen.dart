import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/controllers/socket_chat_controller.dart';
import 'package:danceattix/controllers/user_controller.dart';
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
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
  final ChatController _chatController = Get.find<ChatController>();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
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
        titleWidget: GetBuilder<ChatController>(
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
            child: GetBuilder<ChatController>(
              builder: (controller) {
                final messages = controller.inboxData?.messages;

                if (messages == null || messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(color: Colors.grey),
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Assets.icons.addImage.svg(),
          SizedBox(width: 10.w),
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
          SizedBox(width: 10.w),
          CustomButton(
            borderRadius: 44.r,
            width: 110.w,
            title: 'Make offer',
            onpress: () {},
          ),
        ],
      ),
    );
  }

}
