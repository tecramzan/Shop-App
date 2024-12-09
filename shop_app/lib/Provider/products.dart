import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shop_app/Provider/product.dart';

class Products with ChangeNotifier {
  List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  var _showFavoritesOnly = false;
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _item.where((productItem) => productItem.isFavorite).toList();
    // }
    return _item;
  }

  List<Product> get favoritesItems {
    return _item.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findbyId(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showFavoritesAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  Future<void> fetchdata()async{
    final url='https://update-product-a83ce-default-rtdb.firebaseio.com/products.json';
  final  respose=await http.get(Uri.parse(url)) ;
  final check =json.decode(respose.body);
  }

  void addProduct(Product product) {
    const url =
        'https://update-product-a83ce-default-rtdb.firebaseio.com/products.json';
    http.post(url as Uri,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'isFavorite': product.isFavorite,
          'imageUrl': product.imageUrl,
        }));


    var newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _item.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _item[prodIndex] = newProduct;
      notifyListeners();
    }
  }
}
