import 'package:flutter/material.dart';
import 'package:wallet/l10n/app_translations.dart';

Future<bool?> showDescriptionDialog(BuildContext context,
    String? message) async {
  final displayMessage = (message == null || message.trim().isEmpty|| message == '')
      ? LocalizationService.instance.tr.notePrompt // fallback key
      : message;
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            LocalizationService.instance.tr.noteOrDescription,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          content: Text(displayMessage,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      actionsAlignment: MainAxisAlignment.
      end
      ,
      );
    },
  );
}
