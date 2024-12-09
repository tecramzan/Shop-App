import 'package:flutter/material.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  UserProductItem({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: id);
                print(id);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.purple,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
