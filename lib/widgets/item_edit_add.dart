import 'package:flutter/material.dart';

class AddEditItemWidget extends StatefulWidget {
  final Function editAddItem;
  // if old name not null this mean that we edit name not adding new
  final String oldName;
  //if isNeeded in not null then it is new subitem
  final bool isNeeded;
  AddEditItemWidget(this.editAddItem, {this.oldName, this.isNeeded});
  @override
  _AddEditItemWidgetState createState() => _AddEditItemWidgetState();
}

class _AddEditItemWidgetState extends State<AddEditItemWidget> {
  var isCanSubmit = false;
  var itemName = TextEditingController();
  var hintText = '';
  FocusNode myFocusNode;
  void addNewItem(String name) async {
    if (isCanSubmit) {
      if (widget.oldName == null) { // its new item not edit
        if (widget.isNeeded == null) { // its main item not sub item
          setState(() {
            itemName.clear();
            isCanSubmit = false;
            myFocusNode.requestFocus();
          });
          //I make the request after i clear the field for better exprience
          await widget.editAddItem(name);
        } else {//its sub item not main item
          setState(() {
            itemName.clear();
            isCanSubmit = false;
            myFocusNode.requestFocus();
          });
          //I make the request after i clear the field for better exprience
          await widget.editAddItem(name,widget.isNeeded);
        }
      } else {// we editing not adding new
        await widget.editAddItem(name);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    itemName = widget.oldName == null
        ? TextEditingController()
        : TextEditingController(text: widget.oldName);
    myFocusNode = FocusNode();
    hintText = widget.oldName == null ? 'Add new item' : 'type your new name'; 
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: ListTile(
        title: Container(
          child: TextField(
            controller: itemName,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none, hintText: hintText),
            onSubmitted: (name) {
              addNewItem(name);
            },
            onChanged: (val) {
              if (val.length > 0) {
                setState(() {
                  isCanSubmit = true;
                });
              } else {
                setState(() {
                  isCanSubmit = false;
                });
              }
            },
            autofocus: true,
            focusNode: myFocusNode,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: isCanSubmit ? Colors.blue[900] : Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_upward_rounded,
              size: 20,
            ),
            color: Colors.white,
            onPressed: () {
              addNewItem(itemName.text);
            },
          ),
        ),
      ),
    );
  }
}
