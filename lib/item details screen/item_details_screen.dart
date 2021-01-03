import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/colors_provider.dart';
import '../providers/item_provider.dart';
import 'item_widget.dart';
import 'allSubItems.dart';

class ItemDetails extends StatelessWidget {
  static const route = '/item-details';
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorsProvider>(context);
    final itemProvider =
        ModalRoute.of(context).settings.arguments as ItemProvider;
    return ChangeNotifierProvider.value(
      value: itemProvider,
      child: Scaffold(
        body: SingleChildScrollView(
          child: AllSubItems()
        ),
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: colors.colorPallet.textColor, //change your color here
            ),
            title: Text(
              'Myshwary',
              style: TextStyle(color: colors.colorPallet.textColor),
            ),
            backgroundColor: colors.colorPallet.appBgColor,
            bottom: PreferredSize(
                child: ItemWidget(),
                preferredSize: const Size.fromHeight(40.0))),
      ),
    );
  }
}
