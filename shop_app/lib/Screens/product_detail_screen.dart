import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/Provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // ProductDetailScreen(this.title);
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findbyId(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(loadedProduct.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            loadedProduct.price.toString(),
          ),
          Text(loadedProduct.description),
        ],
      ),
    );
  }
}
