import 'package:flutter/material.dart';
import 'drawer_items.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(child: DrawerItems(),
    );
  }
}
