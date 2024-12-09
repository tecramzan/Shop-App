import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/Provider/orders.dart';

class Customorder extends StatefulWidget {
  final OrdersItem order;

  const Customorder({super.key, required this.order});

  @override
  State<Customorder> createState() => _CustomorderState();
}

class _CustomorderState extends State<Customorder> {
  bool _isExpaned = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy mm:hh').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {});
                  _isExpaned = !_isExpaned;
                },
                icon: Icon(_isExpaned ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            if (_isExpaned)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: min(widget.order.products.length * 20.0 + 100, 100),
                child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                            children: [
                              Text(prod.title),
                              Spacer(),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
          ],
        ),
      ),
    );
  }
}
