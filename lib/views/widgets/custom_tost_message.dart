import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
import 'package:get/get.dart';

String? _lastMessage;
DateTime? _lastShownTime;

void showToast(String message, {int? seconds}) {
  final now = DateTime.now();
  final duration = seconds ?? 3;

  // Debounce duplicate toasts
  if (_lastMessage == message &&
      _lastShownTime != null &&
      now.difference(_lastShownTime!).inSeconds < duration) {
    return;
  }

  _lastMessage = message;
  _lastShownTime = now;

  // Wait for the current frame to finish (navigation/dispose) before showing
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final context = Get.context;
    if (context == null) return;

    // Ensure the overlay is still available
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.rawSnackbar(
      messageText: AutoTranslate(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
        },
        child: Text(
          "×",
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 20,
            height: 1,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1F1F1F),
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
    );
  });
}
