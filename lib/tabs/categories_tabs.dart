import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lojaapp/tiles/category_tile.dart';

class CategoriesTab extends StatelessWidget {

  Future<List> _getCategories() async {
    http.Response response = await http.get("http://10.0.2.2:3000/categories");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCategories(),
      builder: (context, snapshot) {
        if (! snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: ListTile.divideTiles(
              tiles: this._categoryTile(snapshot.data),
              color: Colors.grey[500],
            ).toList(),
          );
        }
      },
    );
  }

  List<CategoryTile> _categoryTile(List categories) {
    return categories.map((category) {
      return CategoryTile(category);
    }).toList();
  }
}
