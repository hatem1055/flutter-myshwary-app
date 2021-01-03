import 'package:flutter/material.dart';
import '../widgets/item_edit_add.dart';

void startAddEditItem(ctx, Function addEditItem,
    {String oldName, bool isNeeded}) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        if(oldName == null){ // its new not edit
          if(isNeeded == null){ // its main item not subitem
            return AddEditItemWidget(addEditItem);
          }else{ // its subitem
            return AddEditItemWidget(
                    addEditItem,
                    isNeeded: isNeeded,
                  );
          }
        }else{ // it is edit 
          return AddEditItemWidget(addEditItem, oldName: oldName);
        }
      },
      isScrollControlled: true);
}
