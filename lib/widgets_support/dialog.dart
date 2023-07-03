import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSimpleDialog(
  BuildContext context, {
  required String title,
  String description = '',
  String dismissButtonLabel = 'Dismiss',
}) {
  if (Platform.isAndroid) {
    _showMaterialSimpleDialog(context, title, description, dismissButtonLabel);
  }

  if (Platform.isIOS) {
    _showCupertinoSimpleDialog(context, title, description, dismissButtonLabel);
  }
}

void _showMaterialSimpleDialog(
  BuildContext context,
  String title,
  String description,
  String buttonLabel,
) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            child: Text(buttonLabel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

void _showCupertinoSimpleDialog(
  BuildContext context,
  String title,
  String description,
  String buttonLabel,
) {
  showCupertinoModalPopup<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(buttonLabel),
            onPressed: () => Navigator.pop(context),
          ),
        ]),
  );
}
