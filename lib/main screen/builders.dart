import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'item_widget.dart';

Widget buildItemsWidget(List<ItemProvider> items) {
  final res = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        return ChangeNotifierProvider.value(
            key: ValueKey(items[i].id),
            value: items[i],
            child: ItemWidget());
          });
  return res;
}