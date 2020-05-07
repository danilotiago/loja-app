import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatelessWidget {
  Future<List> _getImages() async {
    http.Response response = await http.get("http://10.0.2.2:3000/home");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    /**
     * monta o degrade de fundo
     */
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: _getImages(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                    break;
                  default:
                    if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return SliverStaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          staggeredTiles: this._toStaggeredTile(snapshot.data),
                          children: this._toFadeInImage(snapshot.data));
                    }
                }
              },
            )
          ],
        )
      ],
    );
  }

  List<StaggeredTile> _toStaggeredTile(List data) {
    return data.map((item) {
      return StaggeredTile.count(item["x"], item["y"]);
    }).toList();
  }

  List<Widget> _toFadeInImage(List data) {
    return data.map((item) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item["name"],
        fit: BoxFit.cover,
      );
    }).toList();
  }
}
