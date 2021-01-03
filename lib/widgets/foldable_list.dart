import 'package:flutter/material.dart';

class FoldableList extends StatefulWidget {
  final List list;
  final Function lisBuilder;
  final Widget listWidget; // of this null then we are not in subitems screen
  final String listTitle;
  final int listLength;
  FoldableList(
      {
      @required this.list,
      this.lisBuilder,
      @required this.listLength,
      @required this.listTitle,
      this.listWidget});

  @override
  _FoldableListState createState() => _FoldableListState();
}

class _FoldableListState extends State<FoldableList> {
  var showList = false;
  void toggleShowCompleted() {
    setState(() {
      showList = !showList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        if (widget.list.isEmpty == false)
          GestureDetector(
            onTap: toggleShowCompleted,
            child: Row(
              children: [
                IconButton(
                    icon:
                        Icon(showList ? Icons.expand_less : Icons.expand_more),
                    onPressed: toggleShowCompleted),
                Text(
                  '${widget.listTitle}  ${widget.listLength}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        if (showList)
          widget.listWidget == null
              ? widget.lisBuilder(widget.list)
              : widget.listWidget,
      ],
    );
  }
}
