import 'package:flutter/material.dart';

final class PagingIndicator extends StatelessWidget {
  final int locationCount;
  final int currentPage;

  const PagingIndicator({super.key, required this.locationCount, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      color: colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(locationCount + 1, (index) {
          final isCurrentPage = index == currentPage;
          final isSearchPage = index == 0;

          final iconData = isSearchPage ? Icons.search : Icons.circle;
          final iconSize = isSearchPage ? 14 : 12;
          final iconColor =
              isCurrentPage ? colorScheme.onPrimary : colorScheme.onPrimary.withOpacity(0.3);

          return Container(
            padding: const EdgeInsets.all(4),
            child: Icon(iconData, size: iconSize.toDouble(), color: iconColor),
          );
        }),
      ),
    );
  }
}
