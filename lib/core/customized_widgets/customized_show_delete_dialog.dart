import 'package:flutter/material.dart';
import 'package:wallet/l10n/app_translations.dart';

Future<bool?> showDeleteAllDialog(BuildContext context, String title, String message) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title:  Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              LocalizationService.instance.tr.cancel,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true); // confirm delete
            },
            child: Text(
              LocalizationService.instance.tr.delete,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
