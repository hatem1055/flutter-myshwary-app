import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main screen/fetch_items_widget.dart';
import 'providers/items_provider.dart';
import 'providers/colors_provider.dart';
import 'item details screen/item_details_screen.dart';
import 'subitems_screen/subitems_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider() ),
        ChangeNotifierProvider(create: (_) => ColorsProvider() ),
      ],
      child: MaterialApp(
        title: 'Myshwary',
        initialRoute: '/',
        routes: {'/': (ctx) => FetchItemsWidget(),
        ItemDetails.route : (ctx) => ItemDetails(),
        SubItemsScreen.route:(ctx)=>SubItemsScreen()
        },
      ),
    );
  }
}
