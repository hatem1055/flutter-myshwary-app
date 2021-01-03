import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'subitem.dart';

Widget buildSubItemsWidget(List<SubItemProvider> items) {
  final res = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        return ChangeNotifierProvider.value(
            key: ValueKey(items[i].id),
            value: items[i],
            child: SubItemWidget());
          });
  return res;

}