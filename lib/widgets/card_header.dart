import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  final String text;

  const CardHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: textTheme.titleMedium,
      ),
    );
  }
}
