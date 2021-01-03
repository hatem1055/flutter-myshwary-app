import 'package:flutter/material.dart';

class ItemName extends StatefulWidget {
  final String itemName;
  final bool isDone;
  ItemName(this.itemName, this.isDone);

  @override
  _ItemNameState createState() => _ItemNameState();
}

class _ItemNameState extends State<ItemName> {
  String formatedName = '';

  String formatStr(String str) {
    String newStr = '';
    int counter = 0;
    for (final char in str.split('')) {
      if (counter > 20 && char == ' ') {
        newStr += '\n';
        counter = 0;
      } else {
        newStr += char;
      }
      counter++;
    }
    return newStr;
  }

  @override
  Widget build(BuildContext context) {
    formatedName = formatStr(widget.itemName);
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          formatedName,
          style: TextStyle(
              fontSize: 17,
              decoration: widget.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ),
    );
  }
}
