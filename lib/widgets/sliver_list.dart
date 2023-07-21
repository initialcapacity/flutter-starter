import 'package:flutter/cupertino.dart';

SliverList sliverListFromList<T>(
        List<T> data, Widget Function(BuildContext context, T item) builder) =>
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => builder(context, data[index]),
        childCount: data.length,
      ),
    );
