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

  final context = Get.context;
  if (context == null) return;

  // Clear any existing snackbar first to avoid queue buildup
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Expanded(
            child: AutoTranslate(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Text(
              "×",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 20,
                height: 1,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1F1F1F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: Duration(seconds: duration),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    ),
  );
}