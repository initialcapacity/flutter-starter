import 'dart:io';

import 'package:flutter/material.dart';

final class PageLayout extends StatelessWidget {
  final String title;
  final Widget? body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const PageLayout({
    super.key,
    required this.title,
    this.body,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // iOS title is centered
    // Android is left aligned to which we add left padding
    final titlePadding =
        Platform.isAndroid ? const EdgeInsets.only(left: 16) : const EdgeInsets.all(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Container(
          padding: titlePadding,
          child: Text(
            title,
            style: textTheme.titleLarge,
            textScaleFactor: 1.5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: actions,
        toolbarHeight: 80,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
