import 'package:flutter/material.dart';
import 'package:lojaapp/models/user_model.dart';
import 'package:lojaapp/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _fullnameController = TextEditingController();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController  = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // para acessar o form
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("ENTRAR", style: TextStyle(
              fontSize: 15.0
            )),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen()
              ));
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
                  controller: _fullnameController,
                  decoration: InputDecoration(
                      hintText: "Nome Completo"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido";
                    else return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: "Endereço"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido";
                    else return null;
                  },
                ),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Criar conta",
                          style: TextStyle(
                              fontSize: 18.0
                          )),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (this._formKey.currentState.validate()) {

                          Map<String, dynamic> userData = {
                            "fullname": _fullnameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                            "password": _passwordController.text,
                          };

                          model.signUp(
                              userData: userData,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
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
    this._scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2)
      )
    );
    Future.delayed(Duration(seconds: 2)).then((result) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    this._scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2)
        )
    );
  }
}
