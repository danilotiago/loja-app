import 'package:flutter/cupertino.dart';
import 'package:lojaapp/models/user_logged.dart';
import 'package:lojaapp/services/user_service.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {

  final UserService _userService = UserService();

  bool isLoading = false;
  UserLogged userLogged;

  final fixedUserDataToLogin = {
    'email': 'email@email.com'
  };

  // executa na instanciacao da classe ??
  @override
  void addListener(listener) {
    super.addListener(listener);
    this.signIn(userData: fixedUserDataToLogin, onSuccess: (){}, onFail: (){});
  }

  void signIn({@required Map<String, dynamic> userData,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) {
    this._userService.signIn(userData: userData)
        .then((userLogged) {
      this.userLogged = userLogged;

      onSuccess();
      this.isLoading = false;
      notifyListeners();

    }).catchError((err) {
      print(err);

      onFail();
      this.isLoading = false;
      notifyListeners();

    });

    this.isLoading = true;
    notifyListeners(); // avisa aos listeners que alteramos a model


  }

  void signOut() {
    // chamar api de signout

    this.userLogged = null;

    notifyListeners();
  }

  void signUp({@required Map<String, dynamic> userData,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async {

    this.isLoading = true;
    notifyListeners(); // avisa aos listeners que alteramos a model

    this._userService.signUp(userData: userData)
      .then((userLogged) {
         this.userLogged = userLogged;

         onSuccess();
         this.isLoading = false;
         notifyListeners();

      }).catchError((err) {
        print(err);

        onFail();
        this.isLoading = false;
        notifyListeners();

      });
  }

  bool isLoggedIn() {
    return userLogged != null;
  }
}