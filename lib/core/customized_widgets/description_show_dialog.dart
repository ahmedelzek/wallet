import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../resources/app_sizes.dart';

Future<bool?> showDescriptionDialog(
  BuildContext context,
  String? message,
) async {
  final tr = LocalizationService.instance.tr(context);
  final displayMessage =
      (message == null || message.trim().isEmpty || message == '')
          ? tr.notePrompt
          : message;
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.p16),
        ),
        title: Text(
          tr.noteOrDescription,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.s12),
        ),
        content: Text(
          displayMessage,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.s18),
        ),
        actionsAlignment: MainAxisAlignment.end,
      );
    },
  );
}
