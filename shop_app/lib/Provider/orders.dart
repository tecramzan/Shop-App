import 'package:flutter/material.dart';
import 'package:shop_app/Provider/cart.dart';

class OrdersItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrdersItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  
  List<OrdersItem> _orders = [];

  List<OrdersItem> get order {
    return _orders;
  }

  void addOrders(List<CartItem> orderProduct, double total) {
    _orders.insert(
      0,
      OrdersItem(
        id: DateTime.now().toString(),
        amount: total,
        products: orderProduct,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
