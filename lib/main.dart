import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/orders.dart';
import 'package:shop/screens/product_form.dart';
import 'package:shop/screens/user_product.dart';

import 'models/cart.dart';
import 'models/orders.dart';
import 'models/product.dart';
import 'screens/cart.dart';
import 'screens/product_detail.dart';
import 'screens/products_overview.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders())
      ],
      child: ShooperApp(),
    ),
  );
}

class ShooperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOOPER',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        OrdersScreen.routeName: (ctx) => OrdersScreen(),
        UserProductScreen.routeName: (ctx) => UserProductScreen(),
        ProductFormScreen.routeName: (_) => ProductFormScreen(),
      },
    );
  }
}
