import 'package:danceattix/controllers/chat_controller.dart';
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

  // Dummy Chat List
  final List<Map<String, dynamic>> _dummyMessages = [
    {"text": "Hey! How are you?", "time": "10:20 AM", "isMe": false},
    {"text": "I'm good, what about you?", "time": "10:22 AM", "isMe": true},
    {
      "text": "Doing well, thanks for asking!",
      "time": "10:25 AM",
      "isMe": false,
    },
    {"text": "Are you free this evening?", "time": "10:28 AM", "isMe": false},
    {"text": "Yes, I am. Any plans?", "time": "10:30 AM", "isMe": true},
    {"text": "Let’s catch up at the café.", "time": "10:32 AM", "isMe": false},
    {"text": "Perfect, see you then!", "time": "10:35 AM", "isMe": true},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0.w,
      appBar: CustomAppBar(
        titleWidget: GetBuilder<ChatController>(
          builder: (controller) {
            if(controller.inboxData?.conversation == null){
              return const SizedBox();
            }
            final conversation = controller.inboxData?.conversation;

            return CustomListTile(
              contentPaddingHorizontal: 0,
              imageRadius: 24.r,
              image: conversation?.image ?? 'N/A',
              title: conversation?.name ?? 'N/A',
            );
          }
        ),
        actions: [
          IconButton(
            onPressed: () {
             // Get.toNamed(AppRoutes.infoScreen);
            },
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ChatController>(
              builder: (controller) {
                if(controller.inboxData?.messages == null && controller.inboxData!.messages!.isEmpty){
                  return const SizedBox();
                }

                final chat = controller.inboxData?.messages;

                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  itemCount: chat?.length ?? 0,
                  itemBuilder: (context, index) {
                    final message = chat?[index];
                    final isMe = message?.senderId == Get.find<UserController>().userData?.id;

                    final List<String> images = message!.attachments!.map((e) => e.fileUrl ?? '').toList();
                    return ChatBubbleMessage(
                      images: images,
                      text: message.msg,
                      time: message.createdAt ?? '',
                      isMe: isMe,
                    );
                  },
                );
              }
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
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_messageController.text.isNotEmpty) {
                    setState(() {
                      _dummyMessages.add({
                        "text": _messageController.text,
                        "time": "Now",
                        "isMe": true,
                      });
                    });
                    _messageController.clear();
                  }
                },
                child: Assets.icons.massegeSend.svg(),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          CustomButton(
            borderRadius: 44.r,
            width: 110.w,
              title: 'Make offer', onpress: (){

          })
        ],
      ),
    );
  }
}
