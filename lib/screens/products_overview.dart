import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/cart.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';

import 'package:shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavorit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shooper'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(
                CartScreen.routeName,
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            itemBuilder: (_) => <PopupMenuItem>[
              PopupMenuItem(
                child: Text('Only Favorit'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
            onSelected: (value) {
              setState(() => _showFavorit = value == FilterOptions.Favorite);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showFavorit),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final bool favorit;

  ProductGrid(this.favorit);

  @override
  Widget build(BuildContext context) {
    List<Product> productList = favorit
        ? Provider.of<ProductList>(context).favoriteList
        : Provider.of<ProductList>(context).items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        child: ProductItem(),
      ),
    );
  }
}
