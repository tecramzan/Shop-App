import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/orders.dart';
import 'package:shop_app/Widgets/customOrder.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = 'order-screen';
  
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Your ordders'),
      ),
      body: orderData.order.isEmpty
          ? Center(
              child: Text('Orders not added yet!'),
            )
          : ListView.builder(
              itemCount: orderData.order.length,
              itemBuilder: (context, index) {
                return Customorder(order: orderData.order[index]);
              }),
    );
  }
}
