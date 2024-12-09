import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/cart.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/badge.dart';

import '../Widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

var _showFavoritesOnly = false;

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // print('===Build Called==');
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showFavoritesOnly = true;
                  } else {
                    _showFavoritesOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOptions.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (context, value, ch) => CustomBadge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                )),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
