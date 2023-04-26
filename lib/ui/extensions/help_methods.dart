import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';

/// help_methods contains methods that are helping us (it's like a toolbox Lol;) ) in Ui and Services

void snackBar(String text, context,
    {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey, Color? color}) {
  if (scaffoldMessengerKey != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: TextView(
        text: text,
        color: color ?? white,
        size: 12,
      ),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: TextView(
        text: text,
        color: color ?? white,
        size: 12,
      ),
    ));
  }
}
