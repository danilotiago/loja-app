import 'package:flutter/material.dart';
import 'package:lojaapp/models/product_model.dart';
import 'package:lojaapp/screens/product_screen.dart';

class ProductItemTile extends StatelessWidget {

  final String _type;
  final Product _product;

  ProductItemTile(this._type, this._product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(this._product))
        );
      },
      child: Card(
        child: this._type == "grid" ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(this._product.images[0]["image"],
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(this._product.name, style: TextStyle(
                      fontWeight: FontWeight.w500
                    )),
                    Text("R\$ ${this._product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                    ))
                  ],
                ),
              ),
            )
          ],
        ) :
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                this._product.images[0]["image"],
                fit: BoxFit.cover,
                height: 250.0,
              )
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this._product.name, style: TextStyle(
                        fontWeight: FontWeight.w500
                    )),
                    Text("R\$ ${this._product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
