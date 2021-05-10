import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class ProductList extends ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'P1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      image:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'P2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'P3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      image: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'P4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items => [..._items];

  List<Product> get favoriteList =>
      _items.where((obj) => obj.isFavorite).toList();

  Product getById(String id) {
    return _items.firstWhere((ele) => ele.id == id);
  }

  Future<void> addProduct(Product newProduct) async {
    try {
      final url = Uri.https(
          'shopper-halaa-default-rtdb.europe-west1.firebasedatabase.app',
          '/products.json');
      final response = await http.post(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'image': newProduct.image,
          'price': newProduct.price,
          'isFavorite': newProduct.isFavorite,
        }),
      );

      final _editProduct = Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        image: newProduct.image,
        price: newProduct.price,
      );

      _items.add(_editProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
