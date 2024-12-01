import 'package:calliverse/Widgets/toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

Future<void> copyToClipboard({required String text, required BuildContext context}) async {
  try {
    await FlutterClipboard.copy(text);
    print('Text copied to clipboard: $text');
    AppToast.show("Copied");
  } catch (e) {
    print('Failed to copy text to clipboard: $e');
    AppToast.show("Failed to copy text to clipboard: $e");
  }
}