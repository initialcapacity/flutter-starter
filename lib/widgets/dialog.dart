import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showSimpleDialog(
  BuildContext context, {
  required String title,
  String description = '',
  String dismissButtonLabel = 'Dismiss',
}) async {
  if (Platform.isAndroid) {
    return _showMaterialSimpleDialog(context, title, description, dismissButtonLabel);
  }

  if (Platform.isIOS) {
    return _showCupertinoSimpleDialog(context, title, description, dismissButtonLabel);
  }
}

Future<void> _showMaterialSimpleDialog(
  BuildContext context,
  String title,
  String description,
  String buttonLabel,
) =>
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

Future<void> _showCupertinoSimpleDialog(
  BuildContext context,
  String title,
  String description,
  String buttonLabel,
) =>
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(title: Text(title), content: Text(description), actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(buttonLabel),
          onPressed: () => Navigator.pop(context),
          ),
        ]),
  );
