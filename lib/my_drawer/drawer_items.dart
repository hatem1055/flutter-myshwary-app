import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../providers/colors_provider.dart';
import '../subitems_screen/subitems_screen.dart';
class DrawerItems extends StatelessWidget {
  Widget drawerItem(context,String title,int itemsLength,bool isNeeded) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Text(itemsLength.toString()),
      onTap: (){
        Navigator.of(context).pushNamed(SubItemsScreen.route,arguments: isNeeded);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final colors = Provider.of<ColorsProvider>(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppBar(
          title: Text('Hello Friend!',style:TextStyle(color: colors.colorPallet.textColor),),
          backgroundColor:colors.colorPallet.appBgColor,
          automaticallyImplyLeading: false,
        ),
        drawerItem(context,'Needed',itemsProvider.getSubItemListLength(true,false),true),
        Divider(),
        drawerItem(context,'should get',itemsProvider.getSubItemListLength(false,false),false)
      ],
    );
  }
}
