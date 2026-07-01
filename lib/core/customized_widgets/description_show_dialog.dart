import 'package:flutter/material.dart';
import 'package:wallet/l10n/app_translations.dart';

Future<bool?> showDescriptionDialog(BuildContext context,
    String? message) async {
  final tr = LocalizationService.instance.tr(context);
  final displayMessage = (message == null || message.trim().isEmpty|| message == '')
      ? tr.notePrompt
      : message;
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            tr.noteOrDescription,
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
