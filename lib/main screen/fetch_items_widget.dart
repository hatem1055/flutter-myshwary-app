import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/items_provider.dart';
import '../vars.dart';
import '../providers/colors_provider.dart';
import 'items_widget.dart';
import '../widgets/start_add_edit_item.dart';
import '../my_drawer/my_drawer.dart';

class FetchItemsWidget extends StatefulWidget {
  @override
  _FetchItemsWidgetState createState() => _FetchItemsWidgetState();
}

class _FetchItemsWidgetState extends State<FetchItemsWidget> {
  void endJourneyDialog(ctx, ItemsProvider itemsProvider) {
    showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text('are you sure you want to delete all items'),
            actions: [
              FlatButton(
                  onPressed: () async {
                    itemsProvider.clearItems();
                    Navigator.of(ctx).pop();
                  },
                  child: Text('yes,iam sure')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('cancel'))
            ],
          );
        },
        barrierDismissible: true);
  }

  Future<void> fetchItems(ItemsProvider itemsProvider) async {
    try {
      http.Response res = await http.get('${Vars.url}/item');
      List data = json.decode(res.body);
      for (final item in data) {
        itemsProvider.addItem(
            id: item['_id'],
            name: item['name'],
            isDone: item['isDone'],
            loadedGetItems: item['shouldGet'],
            loadedNeededItems: item['needed']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
    final colorsProvider = Provider.of<ColorsProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: colorsProvider.colorPallet.bgColor),
        child: IconButton(
          icon: Icon(Icons.add),
          iconSize: 35,
          color: Colors.white,
          onPressed: () {
            startAddEditItem(context, itemsProvider.addNewItem);
          },
        ),
      ),
      backgroundColor: colorsProvider.colorPallet.appBgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colorsProvider.colorPallet.textColor, //change your color here
        ),
        backgroundColor: colorsProvider.colorPallet.appBgColor,
        title: Text(
          'Myshwary',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                endJourneyDialog(context, itemsProvider);
              },
              child: Text(
                'Myshwar Gydyd',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
      body: FutureBuilder(
        future: fetchItems(itemsProvider),
        builder: (ctx, respons) {
          if (respons.connectionState == ConnectionState.done) {
            return ItemsWidget();
          } else if (respons.connectionState == ConnectionState.waiting) {
            return Text('Waiting');
          }
          return Text('ay 7aga');
        },
      ),
    );
  }
}
