import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lojaapp/models/product_model.dart';
import 'package:lojaapp/tiles/product_item_tile.dart';

class ProductsScreen extends StatelessWidget {

  final Map _category;

  ProductsScreen(this._category);

  Future<List<Product>> _getProductsById() async {
    List<Product> products = [];
    http.Response response = await http.get(
        "http://10.0.2.2:3000/products?categoryId=${this._category["id"]}");

    json.decode(response.body).forEach((item) {
      products.add(Product.fromMap(item));
    });

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this._category["name"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<List<Product>>(
          future: _getProductsById(),
          builder: (context, snapshot) {
            if (! snapshot.hasData) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(), // nao deixa arrastar de lado
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ProductItemTile("grid", snapshot.data[index]);
                    }
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ProductItemTile("list", snapshot.data[index]);
                    }
                  )
                ],
              );
            }
          },
        )
      ),
    );
  }

}
