import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'build_subitem.dart';
import '../providers/items_provider.dart';

class BuildItemsSectionsWidget extends StatelessWidget {
  final bool isNeeded;
  final bool isDone;
  BuildItemsSectionsWidget(this.isNeeded,this.isDone);
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsProvider>(context).notCompletedItems;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (_, i) {
        return ChangeNotifierProvider.value(
          key: ValueKey(items[i].id),
          value: items[i],
          child: buildSubItemsWidget(items[i].getSubItems(isNeeded, isDone)),
        );
      });
  }
}
