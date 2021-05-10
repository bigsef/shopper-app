import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_form.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = context.watch<ProductList>().items;
    print(productList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(ProductFormScreen.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) => UserProductItem(
            productList[index].id,
            productList[index].title,
            productList[index].image,
          ),
        ),
      ),
    );
  }
}
