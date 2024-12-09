import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/products.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-screen';
  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('User Produtcs'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
                 
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                UserProductItem(
                  id: productData.items[index].id!,
                  imageUrl: productData.items[index].imageUrl,
                  title: productData.items[index].title,
                ),
                Divider(
                  // thickness: 2,
                  color: Colors.grey,
                ),
              ],
            );
          }),
      drawer: AppDrawer(),
    );
  }
}
