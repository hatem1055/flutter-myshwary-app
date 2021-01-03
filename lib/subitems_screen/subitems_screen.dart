import 'package:flutter/material.dart';
import 'package:myshwary_rewrite/widgets/foldable_list.dart';
import 'package:provider/provider.dart';
import '../providers/colors_provider.dart';
import 'build_item_section.dart';
import '../providers/items_provider.dart';

class SubItemsScreen extends StatelessWidget {
  static const route = '/subitems';
  @override
  Widget build(BuildContext context) {
    final ColorsProvider colors = Provider.of<ColorsProvider>(context);
    final ItemsProvider itemsProvider = Provider.of<ItemsProvider>(context);
    final isNeeded = ModalRoute.of(context).settings.arguments as bool;
    final int completedLength =itemsProvider.getSubItemListLength(isNeeded,true);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colors.colorPallet.textColor, //change your color here
        ),
        backgroundColor: colors.colorPallet.appBgColor,
        title: Text('Myshwary',
            style: TextStyle(color: colors.colorPallet.textColor)),
      ),
      body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildItemsSectionsWidget(isNeeded,false),
          if(completedLength > 0)
          FoldableList(
            list:itemsProvider.notCompletedItems,
            listWidget:BuildItemsSectionsWidget(isNeeded,true),
            listTitle: 'Completed',
            listLength: completedLength,
          )
        ],
      ),
    ),
    );
  }
}
