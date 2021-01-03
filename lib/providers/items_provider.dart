import 'dart:convert';
import 'package:flutter/material.dart';
import 'item_provider.dart';
import 'package:http/http.dart' as http;
import '../vars.dart';

class ItemsProvider with ChangeNotifier {
  final Map<String, ItemProvider> _items = {};
  var index = 0;
  List<ItemProvider> get notCompletedItems {
    return [..._items.values.where((element) => element.isDone == false)];
  }

  List<ItemProvider> get completedItems {
    return [..._items.values.where((element) => element.isDone == true)];
  }

  List<ItemProvider> get allItems {
    return [..._items.values];
  }

  int getSubItemListLength(bool isNeeded,bool isDone) {
    int total = 0;
    if (isNeeded) {
      notCompletedItems.forEach((element) {
        total += element.sortedNeededItems
            .where((element) => element.isDone == isDone)
            .length;
      });
    } else {
      notCompletedItems.forEach((element) {
        total += element.sortedGetItems
            .where((element) => element.isDone == isDone)
            .length;
      });
    }
    return total;
  }

  createSubItemList(List items, isNeeded, parentId) {
    // this method for preparing subitems to be passed directly to ItemProvider
    return [
      ...items.map((item) => SubItemProvider(
            id: item['_id'],
            name: item['name'],
            isDone: item['isDone'],
            isNeeded: true,
            parentId: parentId,
          ))
    ];
  }

  //this for loaded items
  void addItem(
      {String name,
      String id,
      bool isDone,
      List loadedGetItems,
      List loadedNeededItems}) {
    _items.putIfAbsent(
        id, () => ItemProvider(name: name, isDone: isDone, id: id));
    ItemProvider item = _items[id];
    List<SubItemProvider> neededItems =
        createSubItemList(loadedNeededItems, true, item.id);
    List<SubItemProvider> getItems =
        createSubItemList(loadedGetItems, false, item.id);
    item.addSubItems(neededItems, true);
    item.addSubItems(getItems, false);
  }

  Future<void> addNewItem(name) async {
    String body = json.encode({"name": name});
    http.Response res =
        await http.post('${Vars.url}/item', headers: Vars.headers, body: body);
    Map data = json.decode(res.body);
    ItemProvider newItem =
        ItemProvider(name: data['name'], isDone: false, id: data['_id']);
    _items.putIfAbsent(data['_id'], () => newItem);
    notifyListeners();
  }

  void toggleIsDoneForUi(String id, bool val) {
    _items[id].isDone = val;
    notifyListeners();
  }

  Future<void> toggleItemIsDone(id, val) async {
    toggleIsDoneForUi(id, val);
    final http.Response res = await http.patch('${Vars.url}/item-toggle-done',
        body: json.encode({"id": id}), headers: Vars.headers);
    bool actualValue = json.decode(res.body)['isDone'];
    toggleIsDoneForUi(id, actualValue);
  }

  Future<void> _deleteItem(id) async {
    final _url = Uri.parse('${Vars.url}/item');
    final req = http.Request('DELETE', _url);
    final body = json.encode({"id": id});
    req.headers.addAll(Vars.headers);
    req.body = body;
    await req.send();
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }

  Future<void> clearItems() async {
    _items.clear();
    notifyListeners();
    await http.delete('${Vars.url}/end-journey');
  }

  // work arround for rebuilding subitems screen
  void toggleIsDone({parentId, id, val}) {
    if (parentId == null) {
      this.toggleItemIsDone(id, val);
    } else {
      this._items[parentId].toggleIsDone(id, val);
      notifyListeners();
    }
  }

  void delete({parentId, id}) async{
    if (parentId == null) {
      this._deleteItem(id);
    } else {
      await this._items[parentId].deleteSubItem(id);
      notifyListeners();
    }
  }
}
