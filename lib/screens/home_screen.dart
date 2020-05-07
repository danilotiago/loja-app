import 'package:flutter/material.dart';
import 'package:lojaapp/tabs/categories_tabs.dart';
import 'package:lojaapp/tabs/home_tab.dart';
import 'package:lojaapp/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView( // lista todas as telas no children
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(this._pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoriesTab(),
        )
      ],
    );
  }
}