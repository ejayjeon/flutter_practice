import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void appDialog(BuildContext context, String text) {
  showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CLOSE'),
          ),
        ],
      );
    },
  );
}
