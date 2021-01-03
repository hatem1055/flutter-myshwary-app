import 'package:flutter/material.dart';
import 'package:myshwary_rewrite/providers/colors_provider.dart';
import 'item_name.dart';
import 'package:provider/provider.dart';
class GeneralItemWidget extends StatelessWidget {
  final String name;
  final bool isDone;
  final String id;
  final Function deleteItem;
  final Function toggleIsDone; 
  final String parentId;
  GeneralItemWidget({
    @required this.name,
    @required this.isDone,
    @required this.toggleIsDone,
    @required this.deleteItem,
    @required this.id,
    this.parentId
  });
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorsProvider>(context);
    return ListTile(
      leading: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(children: [
          Checkbox(
            value: isDone,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: colors.colorPallet.bgColor.withOpacity(.8),
            onChanged: (val) {
              toggleIsDone(id:id, val:val,parentId:parentId);
            },
          ),
          ItemName(name, isDone)
        ]),
      ),
      trailing: IconButton(
        onPressed: () {
          deleteItem(parentId:parentId,id:id);
        },
        icon: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
