import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../providers/item_provider.dart';
import '../item details screen/item_details_screen.dart';
import '../widgets/general_item_widget.dart';

class ItemWidget extends StatefulWidget {
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemProvider>(context);
    final items = Provider.of<ItemsProvider>(context, listen: false);
    return Hero(
      tag: {
        'id':item.id
      },
      transitionOnUserGestures: true,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ItemDetails.route, arguments: item);
        },
        child: Card(
          elevation: 0.8,
          child: GeneralItemWidget(
              name: item.name,
              isDone: item.isDone,
              toggleIsDone: items.toggleIsDone,
              deleteItem: items.delete,
              id: item.id),
        ),
      ),
    );
  }
}
