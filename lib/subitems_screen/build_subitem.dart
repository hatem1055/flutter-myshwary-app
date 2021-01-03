import 'package:flutter/material.dart';
import '../providers/item_provider.dart';
import 'package:provider/provider.dart';
import '../item details screen/subitem.dart';
Widget buildSubItemsWidget(List<SubItemProvider> items) {
  final res = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        return ChangeNotifierProvider.value(
            key: ValueKey(items[i].id),
            value: items[i],
            child:Card(
              elevation: 0.8,
              child:SubItemWidget(),
            ),);
          });
  return res;
}