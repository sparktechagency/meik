import 'package:danceattix/controllers/chat_controller.dart';
import 'package:danceattix/models/inbox_model_data.dart';
import 'package:danceattix/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocketChatController extends GetxController {
  final ChatsController _chatController = Get.find<ChatsController>();

  final Set<String> _activeListeners = {};

  /// Listen for new messages via socket.
  void listenMessage(String conversationId) {
    SocketServices.instance .socket?.off("conversation-$conversationId");

    SocketServices.instance.socket?.on("conversation-$conversationId", (data) {
      debugPrint("=========> Response Message: $data");
      debugPrint(
        "=========> Received at: ${DateTime.now().millisecondsSinceEpoch}",
      );

      if (data == null) return;

      try {
        final newMessage = Messages.fromJson(data as Map<String, dynamic>);

        // Deduplicate by message id
        final alreadyExists =
            _chatController.inboxData?.messages?.any(
              (m) => m.id == newMessage.id,
            ) ??
            false;

        if (alreadyExists) {
          debugPrint(
            "=========> Duplicate message ignored: id=${newMessage.id}",
          );
          return;
        }

        _chatController.inboxData?.messages?.insert(0, newMessage);
        _chatController.update();
      } catch (e) {
        debugPrint("=========> Failed to parse message: $e");
      }
    });
  }

  /// Send a new message via socket.
  void sendMessage({required String message, required String conversationId}) {
    final body = {"conversation_id": conversationId, "msg": message};
    SocketServices.instance.emit('send-message', body);
  }

  void removeListeners(String conversationId) {
    SocketServices.instance.socket?.off("conversation-$conversationId");
    _activeListeners.remove(conversationId);
  }

  @override
  void onClose() {
    for (final id in _activeListeners.toList()) {
      removeListeners(id);
    }
    super.onClose();
  }
}
