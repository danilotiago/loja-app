import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController _pageController;
  final int _page;

  DrawerTile(this.icon, this.text, this._pageController, this._page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          this._pageController.jumpToPage(this._page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(this.icon,
                size: 32.0,
                color: this._pageController.page.round() == this._page ?
                    Theme.of(context).primaryColor :
                    Colors.grey[700]
              ),
              SizedBox(width: 32.0),
              Text(this.text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: this._pageController.page.round() == this._page ?
                      Theme.of(context).primaryColor :
                      Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
