import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/cart.dart';

class CartItems extends StatelessWidget {
  final String title;
  final String id;
  final String productId;
  final double price;
  final int quantity;
  CartItems({
    super.key,
    required this.id,
    required this.title,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text('$title'),
            subtitle: Text('\$${price * quantity}'),
            trailing: Text('${quantity}X'),
          ),
        ),
      ),
    );
  }
}
