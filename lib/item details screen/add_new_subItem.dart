import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/start_add_edit_item.dart';
import '../providers/item_provider.dart';

class AddNewSubitem extends StatefulWidget {
  final bool isNeeded;
  final String hintText;
  AddNewSubitem(this.isNeeded,this.hintText);
  @override
  _AddNewSubitemState createState() => _AddNewSubitemState();
}

class _AddNewSubitemState extends State<AddNewSubitem> {

  @override
  Widget build(BuildContext context) {
    final ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    return GestureDetector(
            onTap: () {
              startAddEditItem(context, itemProvider.addNewSubItem,isNeeded:widget.isNeeded);
            },
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text(widget.hintText),
            ),
          );
  }
}
