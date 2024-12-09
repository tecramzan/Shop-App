import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/cart.dart';
import 'package:shop_app/Provider/orders.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Your Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.all(11),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrders(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();
                      },
                      child: Text('ORDER NOW'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, i) {
                  return CartItems(
                      id: cart.items.values.toList()[i].id,
                      title: cart.items.values.toList()[i].title,
                      productId: cart.items.keys.toList()[i],
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity);
                }),
          )
        ],
      ),
    );
  }
}
