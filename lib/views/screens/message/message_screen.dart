import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_constants/app_colors.dart';
import '../../../core/config/app_route.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  bool isDarkTheme = false;
  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController(
      initialMessageList: Data.messageList,
      scrollController: ScrollController(),
      currentUser: const ChatUser(
        id: '1',
        name: 'Flutter',
        profilePhoto: Data.profileImage,
      ),
      otherUsers: const [
        ChatUser(
          id: '2',
          name: 'Simform',
          profilePhoto: Data.profileImage,
        ),
        ChatUser(
          id: '3',
          name: 'Jhon',
          profilePhoto: Data.profileImage,
        ),
        ChatUser(
          id: '4',
          name: 'Mike',
          profilePhoto: Data.profileImage,
        ),
        ChatUser(
          id: '5',
          name: 'Rich',
          profilePhoto: Data.profileImage,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // ChatController should be disposed to avoid memory leaks
    _chatController.dispose();
    super.dispose();
  }

  void _showHideTypingIndicator() {
    _chatController.setTypingIndicator = !_chatController.showTypingIndicator;
  }

  void receiveMessage() async {
    _chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        message: 'I will schedule the meeting.',
        createdAt: DateTime.now(),
        sentBy: '2',
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _chatController.addReplySuggestions([
      const SuggestionItemData(text: 'Thanks.'),
      const SuggestionItemData(text: 'Thank you very much.'),
      const SuggestionItemData(text: 'Great.')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatView(
        chatController: _chatController,
        onSendTap: _onSendTap,
        featureActiveConfig: const FeatureActiveConfig(
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: true,
          enableScrollToBottomButton: true,
        ),
        scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
          backgroundColor: theme.textFieldBackgroundColor,
          border: Border.all(
            color: isDarkTheme ? Colors.transparent : Colors.grey,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.themeIconColor,
            weight: 10,
            size: 30,
          ),
        ),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.outgoingChatBubbleColor,
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),


        appBar: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.chatProfileScreen);
          },
          child: ChatViewAppBar(

            elevation: theme.elevation,
            backGroundColor: theme.appBarColor,
            profilePicture: Data.profileImage,
            backArrowColor: theme.backArrowColor,
            chatTitle: "Cat Travel Bag (Sagor)",
            chatTitleTextStyle: TextStyle(
              color: theme.appBarTitleTextStyle,
              fontWeight: FontWeight.bold,
              fontSize: 14.h,
              letterSpacing: 0.25,
            ),

            userStatus: "last active 23 hr ago",
            userStatusTextStyle: const TextStyle(color: Colors.grey),
            actions: [
              // IconButton(
              //   onPressed: _onThemeIconTap,
              //   icon: Icon(
              //     isDarkTheme
              //         ? Icons.brightness_4_outlined
              //         : Icons.dark_mode_outlined,
              //     color: theme.themeIconColor,
              //   ),
              // ),
              // IconButton(
              //   tooltip: 'Toggle TypingIndicator',
              //   onPressed: _showHideTypingIndicator,
              //   icon: Icon(
              //     Icons.keyboard,
              //     color: theme.themeIconColor,
              //   ),
              // ),
              // IconButton(
              //   tooltip: 'Simulate Message receive',
              //   onPressed: receiveMessage,
              //   icon: Icon(
              //     Icons.supervised_user_circle,
              //     color: theme.themeIconColor,
              //   ),
              // ),

              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
            ],
          ),
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 17.h,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        sendMessageConfig: SendMessageConfiguration(
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraIconColor: theme.cameraIconColor,
            galleryIconColor: theme.galleryIconColor,
          ),
          replyMessageColor: Colors.black87,
          defaultSendButtonColor: Colors.black,
          // theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint(status.toString());
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: theme.textFieldTextColor),
          ),
          // micIconColor: theme.replyMicIconColor,
          // voiceRecordingConfiguration: VoiceRecordingConfiguration(
          //   backgroundColor: theme.waveformBackgroundColor,
          //   recorderIconColor: theme.recordIconColor,
          //   waveStyle: WaveStyle(
          //     showMiddleLine: false,
          //     waveColor: theme.waveColor ?? Colors.white,
          //     extendWaveform: true,
          //   ),
          // ),
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
              linkPreviewConfig: LinkPreviewConfiguration(
                backgroundColor: theme.linkPreviewOutgoingChatColor,
                bodyStyle: theme.outgoingChatLinkBodyStyle,
                titleStyle: theme.outgoingChatLinkTitleStyle,
              ),
              receiptsWidgetConfig: const ReceiptsWidgetConfig(
                  showReceiptsIn: ShowReceiptsIn.all),
              color: theme.outgoingChatBubbleColor,
              textStyle: TextStyle(color: Colors.black)),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle,
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            color: theme.inComingChatBubbleColor,
          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
          backgroundColor: theme.replyPopupColor,
          buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
          topBorderColor: theme.replyPopupTopBorderColor,
        ),
        reactionPopupConfig: ReactionPopupConfiguration(
          shadow: BoxShadow(
            color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
            blurRadius: 20,
          ),
          backgroundColor: theme.reactionPopupColor,
        ),
        messageConfig: MessageConfiguration(
          customMessageBuilder: (message) {
            return customOfferMessage(
                title: "Cat Travel Gag",
                status: "Buyer offers you a price",
                imageUrl: "https://i.pravatar.cc/150?img=3",
                isSender: true,
                price: "\$10",
                buttons: [
                  Expanded(
                      child: CustomButton(
                        loaderIgnore: true,
                        height: 30.h,
                          boderColor: AppColors.primaryColor,
                          titlecolor: AppColors.primaryColor,
                          color: Colors.transparent,
                          fontSize: 12.h,
                          title: "Cancel", onpress: () {})),

                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomButton(
                      loaderIgnore: true,
                      fontSize: 12.h,
                        height: 30.h,
                        title: "Purchase",
                        onpress: () {
                          Get.toNamed(AppRoutes.confirmPurchaseScreen);
                        }),
                  )
                ]);
          },
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
            reactedUserCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.backgroundColor,
              reactedUserTextStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
              ),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.inComingChatBubbleColor,
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                    offset: const Offset(0, 20),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: ShareIconConfiguration(
              defaultIconBackgroundColor: theme.shareIconBackgroundColor,
              defaultIconColor: theme.shareIconColor,
            ),
          ),
        ),
        profileCircleConfig: const ProfileCircleConfiguration(
          profileImageUrl: Data.profileImage,
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.pinkAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          replyIconColor: theme.swipeToReplyIconColor,
        ),
        replySuggestionsConfig: ReplySuggestionsConfig(
            itemConfig: SuggestionItemConfig(
              decoration: BoxDecoration(
                color: theme.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.outgoingChatBubbleColor ?? Colors.white,
                ),
              ),
              textStyle: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            onTap: (item) {
              _chatController.addMessage(
                Message(
                  id: DateTime.now().toString(),
                  createdAt: DateTime.now(),
                  message: "Buyer offers you a price",
                  messageType: MessageType.custom,
                  sentBy: '2',
                ),
              );
            }
            // _onSendTap(item.text, const ReplyMessage(), MessageType.text),
            ),
      ),
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final messageObj = Message(
      id: DateTime.now().toString(),
      createdAt: DateTime.now(),
      message: message,
      sentBy: _chatController.currentUser.id,
      replyMessage: replyMessage,
      messageType: MessageType.custom,
    );
    _chatController.addMessage(
      messageObj,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      final index = _chatController.initialMessageList.indexOf(messageObj);
      _chatController.initialMessageList[index].setStatus =
          MessageStatus.undelivered;
    });
    Future.delayed(const Duration(seconds: 1), () {
      final index = _chatController.initialMessageList.indexOf(messageObj);
      _chatController.initialMessageList[index].setStatus = MessageStatus.read;
    });
  }

  Widget customOfferMessage({
    required bool isSender,
    required String title,
    required String status,
    required String price,
    required String imageUrl,
    required List<Widget> buttons,
  }) {
    return Container(
      width: 320.w,
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      padding:  EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isSender ? const Color(0xFFFFF0DC) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 48.w,
              height: 48.h,
              fit: BoxFit.cover,
            ),
          ),
           SizedBox(width: 8.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomText(text: title, color: Colors.black, fontSize: 16.h, bottom: 4.h),


                CustomText(text: status, bottom: 4.h),
                CustomText(text: price, bottom: 10.h),

                Row(
                  children: [...buttons],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

class Data {
  static const String profileImage =
      "https://i.pravatar.cc/150?img=3"; // Dummy profile image
  static List<Message> messageList = [
    Message(
      id: 'msg1',
      message: 'Hello! How can I help you?',
      sentBy: '2',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Message(
      id: 'msg2',
      message: 'I wanted to ask about your services.',
      sentBy: '1',
      createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
  ];
}

// Dummy theme system
late ChatTheme theme = LightTheme();

class ChatTheme {
  Color appBarColor = Colors.white;
  Color appBarTitleTextStyle = Colors.black;
  Color backArrowColor = Colors.black;
  Color themeIconColor = Colors.black;
  double elevation = 0;
  Color textFieldBackgroundColor = Color(0xffFEF3EA);
  Color outgoingChatBubbleColor = Color(0xffFFD6B0);
  Color inComingChatBubbleColor = Colors.grey.shade300;
  Color inComingChatBubbleTextColor = Colors.black;
  Color messageTimeIconColor = Colors.grey;
  Color messageTimeTextColor = Colors.black;
  Color chatHeaderColor = Colors.black;
  Color cameraIconColor = Colors.black;
  Color galleryIconColor = Colors.black;
  Color replyMessageColor = Colors.black;
  Color sendButtonColor = Colors.blue;
  Color replyDialogColor = Colors.grey.shade300;
  Color replyTitleColor = Colors.black;
  Color closeIconColor = Colors.red;
  Color textFieldTextColor = Colors.black;
  Color replyMicIconColor = Colors.purple;
  Color waveformBackgroundColor = Colors.grey;
  Color recordIconColor = Colors.red;
  Color? waveColor = Colors.white;
  Color linkPreviewOutgoingChatColor = Colors.blue.shade100;
  TextStyle outgoingChatLinkBodyStyle = const TextStyle();
  TextStyle outgoingChatLinkTitleStyle = const TextStyle();
  Color linkPreviewIncomingChatColor = Colors.grey.shade300;
  TextStyle incomingChatLinkBodyStyle = const TextStyle();
  TextStyle incomingChatLinkTitleStyle = const TextStyle();
  Color replyPopupColor = Colors.grey.shade800;
  Color replyPopupButtonColor = Colors.white;
  Color replyPopupTopBorderColor = Colors.white;
  Color reactionPopupColor = Colors.grey.shade300;
  Color messageReactionBackGroundColor = Colors.blue;
  Color shareIconBackgroundColor = Colors.black;
  Color shareIconColor = Colors.white;
  Color repliedMessageColor = Colors.blue.shade100;
  Color verticalBarColor = Colors.blue;
  Color repliedTitleTextColor = Colors.black;
  Color swipeToReplyIconColor = Colors.grey;
  Color flashingCircleBrightColor = Colors.blue;
  Color flashingCircleDarkColor = Colors.blueGrey;
  Color backgroundColor = Colors.white;
}

class LightTheme extends ChatTheme {}

class DarkTheme extends ChatTheme {
  @override
  Color appBarColor = Colors.black;
  @override
  Color appBarTitleTextStyle = Colors.white;
  @override
  Color backArrowColor = Colors.white;
  @override
  Color themeIconColor = Colors.white;
  @override
  Color textFieldBackgroundColor = Colors.grey.shade800;
  @override
  Color outgoingChatBubbleColor = Colors.blue.shade900;
  @override
  Color inComingChatBubbleColor = Colors.grey.shade700;
  @override
  Color inComingChatBubbleTextColor = Colors.white;
  @override
  Color chatHeaderColor = Colors.white;
  @override
  Color textFieldTextColor = Colors.white;
  @override
  Color backgroundColor = Colors.black;
}
