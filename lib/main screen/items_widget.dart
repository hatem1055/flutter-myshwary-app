import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import 'builders.dart';
import '../widgets/foldable_list.dart';

class ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(child: buildItemsWidget(items.notCompletedItems)),
          FoldableList(
              list: items.completedItems,
              lisBuilder: buildItemsWidget,
              listTitle: 'Completed',
              listLength: items.completedItems.length)
        ],
      ),
    );
  }
}
