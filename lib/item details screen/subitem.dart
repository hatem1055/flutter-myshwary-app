import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../providers/item_provider.dart';
import '../widgets/general_item_widget.dart';
import '../widgets/start_add_edit_item.dart';

class SubItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final ItemsProvider itemsProvider = Provider.of<ItemsProvider>(context);
    final SubItemProvider subItemProvider = Provider.of(context);
    return GestureDetector(
      onTap: (){
        startAddEditItem(context, subItemProvider.editName,oldName:subItemProvider.name);
      },
      child: GeneralItemWidget(
        deleteItem: itemsProvider.delete,
        id: subItemProvider.id,
        isDone: subItemProvider.isDone,
        name: subItemProvider.name,
        toggleIsDone: itemsProvider.toggleIsDone,
        parentId: itemProvider.id,
      ),
    );
  }
}
