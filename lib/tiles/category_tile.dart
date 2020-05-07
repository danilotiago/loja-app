import 'package:flutter/material.dart';
import 'package:lojaapp/screens/products_screen.dart';

class CategoryTile extends StatelessWidget {
  final Map category;

  CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.0,
        alignment: Alignment.center,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(category["image"])
          ),
          title: Text(category["name"]),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductsScreen(category))
            );
          },
        ));
  }
}
