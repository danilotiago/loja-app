import 'package:flutter/material.dart';
import 'package:lojaapp/models/user_model.dart';
import 'package:lojaapp/screens/register_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey     = GlobalKey<FormState>(); // para acessar o form
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              // remove a tela atual e vai para a outra
              // com pushReplacement
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RegisterScreen())
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: this._formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "E-mail"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || ! text.contains("@")) return "E-mail inválido";
                    else return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Senha"
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "A senha deve conter pelo menos 6 caracteres";
                    else return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () { },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Entrar",
                          style: TextStyle(
                              fontSize: 18.0
                          )),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (this._formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "email": _emailController.text.trim(),
                            "password": _passwordController.text.trim()
                          };

                          model.signIn(
                              userData: userData,
                              onSuccess: this._onSuccess,
                              onFail: this._onFail);
                        }
                      },
                    )
                )
              ],
            ),
          );
        },
      )
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    this._scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário não encontrado"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2)
        )
    );
  }
}
