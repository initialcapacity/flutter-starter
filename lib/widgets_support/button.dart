import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget primaryButton({
  required void Function() onPressed,
  required String text,
}) {
  if (Platform.isIOS) {
    return CupertinoButton.filled(onPressed: onPressed, child: Text(text));
  }

  return FilledButton(
    onPressed: onPressed,
    child: Text(text),
  );
}
