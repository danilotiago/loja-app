import 'package:flutter/material.dart';
import 'package:lojaapp/models/product_model.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductScreen extends StatefulWidget {

  final Product _product;

  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState(this._product);
}

class _ProductScreenState extends State<ProductScreen> {

  final Product _product;
  String _size;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(this._product.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: this._product.images.map((image) {
                return NetworkImage(image["image"]);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  this._product.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  "R\$ ${this._product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal, // gridview na horizontal
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // qtd de linhas na cross
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    children: this._product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            this._size = size["size"];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color: this._size == size["size"] ?
                                primaryColor :
                                Colors.grey[500],
                              width: 3.0
                            )
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size["size"]),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: this._size != null ?
                      () { } :
                      null,
                    child: Text("Adicionar ao carrinho",
                      style: TextStyle(fontSize: 18.0)
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  this._product.description,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
