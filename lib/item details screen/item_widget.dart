import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/item_name.dart';
import '../providers/item_provider.dart';
import '../providers/items_provider.dart';
import '../providers/colors_provider.dart';
import '../widgets/start_add_edit_item.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemsProvider>(context);
    final item = Provider.of<ItemProvider>(context);
    final colors = Provider.of<ColorsProvider>(context);
    return Container(
      color:colors.colorPallet.appBgColor,
      child: ListTile(
        leading: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(children: [
          Checkbox(
            value: item.isDone,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: colors.colorPallet.bgColor.withOpacity(.8),
            onChanged: (val) {
              items.toggleItemIsDone(item.id, val);
            },
          ),
          GestureDetector(child: ItemName(item.name, item.isDone),onTap: (){
            startAddEditItem(context, item.editItemName,oldName:item.name);
          },)
        ]),
      ))
    );
  }
}
