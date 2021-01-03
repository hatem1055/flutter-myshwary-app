import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/item_provider.dart';
import 'builders.dart';
import '../widgets/foldable_list.dart';
import 'add_new_subItem.dart';

class AllSubItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    final int neededListLenght = itemProvider.sortedNeededItems
        .where((item) => item.isDone == false)
        .length;
    final int getListLenght = itemProvider.sortedGetItems
        .where((item) => item.isDone == false)
        .length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FoldableList(
          listLength: neededListLenght,
          lisBuilder: buildSubItemsWidget,
          list: itemProvider.sortedNeededItems,
          listTitle: 'Needed',
        ),
        AddNewSubitem(true, 'Add the new item you need'),
        FoldableList(
          listLength: getListLenght,
          lisBuilder: buildSubItemsWidget,
          list: itemProvider.sortedGetItems,
          listTitle: 'Should get',
        ),
        AddNewSubitem(false, 'Add the new item you should get'),
      ],
    );
  }
}
