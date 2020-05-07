import 'package:flutter/material.dart';
import 'package:lojaapp/models/user_model.dart';
import 'package:lojaapp/screens/login_screen.dart';
import 'package:lojaapp/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Meu\nEsporte",
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<User>(
                        builder: (context, child, model) {
                          print(model.isLoggedIn());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá, ${
                                    model.isLoggedIn() ? model.userLogged.fullname :
                                    ""}",
                                  style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              )),
                              GestureDetector(
                                child: Text(
                                    model.isLoggedIn() ?
                                    "Sair" :
                                    "Entre ou cadastre-se >",
                                    style: TextStyle(
                                    fontSize: 18.0,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold
                                )),
                                onTap: () {
                                  if (model.isLoggedIn()) {
                                    model.signOut();
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LoginScreen()
                                    ));
                                  }
                                },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início",
                  this._pageController, 0
              ),
              DrawerTile(Icons.list, "Produtos",
                  this._pageController, 1
              ),
              DrawerTile(Icons.location_on, "Lojas",
                  this._pageController, 2
              ),
              DrawerTile(Icons.playlist_add_check, "Meus pedidos",
                  this._pageController, 3
              )
            ],
          )
        ],
      ),
    );
  }
}
