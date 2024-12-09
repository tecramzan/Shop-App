import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/cart.dart';
import 'package:shop_app/Provider/product.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    print('Build CLLED');
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(builder: (ctx, product, _) {
              return IconButton(
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }),
            title: Text(product.title),
            trailing: IconButton(
              onPressed: () {
                cart.addCart(product.id!, product.price, product.title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to your cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        textColor: Colors.deepOrange,
                        onPressed: () {
                          cart.removeSingleitem(product.id!);
                        }),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
