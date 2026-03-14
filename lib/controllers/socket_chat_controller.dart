import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SocketChatController extends GetxController {
  SocketServices socketService = SocketServices();
  final ChatController _chatController = Get.find<ChatController>();




  /// ===============> Listen for new messages via socket.
  void listenMessage(String conversationId) async {
    SocketServices.socket?.on("conversation-$conversationId", (data) {

      debugPrint("=========> Response Message : $data -------------------------");

      if(data != null){

      }

    });
  }




  /// ================> Send a new message via socket.
  void sendMessage({required String message,required String conversationId}) async {
    final body = {
      "conversation_id" : conversationId,
      "msg": message
    };
    socketService.emit('send-message', body);

  }

  void removeListeners(String conversationId) {
    SocketServices.socket?.off("conversation-$conversationId");
  }


}

