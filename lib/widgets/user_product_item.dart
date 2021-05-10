import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_form.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  UserProductItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushNamed(
                  ProductFormScreen.routeName,
                  arguments: id,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => context.read<ProductList>().deleteProduct(id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
