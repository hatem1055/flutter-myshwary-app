import 'package:flutter/material.dart';
import 'package:myshwary_rewrite/providers/colors_provider.dart';
import 'package:myshwary_rewrite/providers/item_provider.dart';
import 'item_name.dart';
import 'package:provider/provider.dart';

class GeneralItemWidget extends StatelessWidget {
  final String name;
  final bool isDone;
  final String id;
  final Function deleteItem;
  final Function toggleIsDone;
  final String parentId;
  GeneralItemWidget(
      {@required this.name,
      @required this.isDone,
      @required this.toggleIsDone,
      @required this.deleteItem,
      @required this.id,
      this.parentId});
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorsProvider>(context);
    final item = Provider.of<ItemProvider>(context);
    return ListTile(
      leading: Container(
        child: Checkbox(
          value: isDone,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          activeColor: colors.colorPallet.bgColor.withOpacity(.8),
          onChanged: (val) {
            toggleIsDone(id: id, val: val, parentId: parentId);
          },
        ),
      ),
      title: ItemName(name, isDone),
      subtitle: parentId == null ? null : Text(item.name),
      trailing: IconButton(
        onPressed: () {
          deleteItem(parentId: parentId, id: id);
        },
        icon: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
