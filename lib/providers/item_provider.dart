import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../vars.dart';

class SubItemProvider with ChangeNotifier {
  String parentId;
  String name;
  bool isDone;
  bool isNewItem;
  bool isNeeded;
  String id;

  SubItemProvider(
      {@required this.name,
      @required this.isDone,
      @required this.id,
      @required this.parentId,
      @required this.isNeeded,
      this.isNewItem});

  Future<void> editName(newName) async {
    String body = json.encode({
      "name": newName,
      "isNeeded": this.isNeeded,
      "parent_id": this.parentId
    });
    http.Response res = await http.post('${Vars.url}/subitem',
        headers: Vars.headers, body: body);
    Map data = json.decode(res.body);
    this.name = data['name'];
    notifyListeners();
  }
}

class ItemProvider with ChangeNotifier {
  String name;
  bool isDone;
  Map<String, SubItemProvider> neededItems = {};
  Map<String, SubItemProvider> getItems = {};
  bool isNewItem;
  String id;
  int index = -1;

  ItemProvider(
      {@required this.name,
      @required this.isDone,
      @required this.id,
      this.isNewItem,
      this.index});

  List<SubItemProvider> _sortList(Map<String, SubItemProvider> list) {
    List<SubItemProvider> doneList =
        list.values.where((element) => element.isDone == true).toList();
    List<SubItemProvider> notDoneList =
        list.values.where((element) => element.isDone == false).toList();
    return [...notDoneList, ...doneList];
  }

  List<SubItemProvider> get sortedNeededItems {
    return _sortList(neededItems);
  }

  List<SubItemProvider> get sortedGetItems {
    return _sortList(getItems);
  }

  List<SubItemProvider> getSubItems(bool isNeeded,bool isDone){
    if(isNeeded){
      return sortedNeededItems.where((item) => item.isDone == isDone).toList();
    }else{
      return sortedGetItems.where((item) => item.isDone == isDone).toList();
    }
  }

  // this for loaded data
  addSubItems(List<SubItemProvider> subItems, bool isNeeded) {
    if (isNeeded) {
      subItems.forEach((item) {
        neededItems.putIfAbsent(item.id, () => item);
      });
    } else {
      subItems.forEach((item) {
        getItems.putIfAbsent(item.id, () => item);
      });
    }
    notifyListeners();
  }

  Future<void> deleteSubItem(id) async {
    final _url = Uri.parse('${Vars.url}/subitem');
    final req = http.Request('DELETE', _url);
    final body = json.encode({"id": id});
    req.headers.addAll(Vars.headers);
    req.body = body;
    await req.send();
    // the sub item is in one of those maps so i delete from both of them to make sure it is deleted
    neededItems.removeWhere((key, value) => key == id);
    getItems.removeWhere((key, value) => key == id);
    notifyListeners();
  }

  Future<void> editItemName(newName) async {
    final body = json.encode({"name": newName, "id": this.id});
    final http.Response res = await http.patch('${Vars.url}/item-change-name',
        body: body, headers: Vars.headers);
    this.name = json.decode(res.body)['name'];
    notifyListeners();
  }

  void _toggleIsDoneForUi(id, val, isNeeded) {
    if (isNeeded) {
      neededItems[id].isDone = val;
    } else {
      getItems[id].isDone = val;
    }
    notifyListeners();
  }

  Future<void> toggleIsDone(id, val) async {
    bool isNeeded = false;
    if (neededItems.containsKey(id)) {
      isNeeded = true;
    }
    _toggleIsDoneForUi(id, val, isNeeded);
    final http.Response res = await http.patch(
        '${Vars.url}/subitem-toggle-done',
        body: json.encode({"id": id}),
        headers: Vars.headers);
    final bool isDone = json.decode(res.body)['isDone'];
    _toggleIsDoneForUi(id, isDone, isNeeded);
  }

  Future<void> addNewSubItem(newName, isNeeded) async {
    String body = json
        .encode({"name": newName, "isNeeded": isNeeded, "parent_id": this.id});
    http.Response res = await http.post('${Vars.url}/subitem',
        headers: Vars.headers, body: body);
    Map data = json.decode(res.body);
    List<SubItemProvider> subItems = [
      SubItemProvider(
          name: newName,
          isDone: false,
          id: data['_id'],
          parentId: this.id,
          isNeeded: isNeeded)
    ];
    addSubItems(subItems, isNeeded);
    notifyListeners();
  }
}
