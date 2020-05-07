import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:lojaapp/models/user_logged.dart';
import 'dart:convert';

class UserService {

  Future<UserLogged> signIn({@required Map<String, dynamic> userData}) async {
    final Map<String, String> queryParameters = {
      "email": userData["email"]
    };

    Uri uri = Uri.http("10.0.2.2:3000", "/authenticate", queryParameters);

    http.Response response = await http.get(uri);

    List body = jsonDecode(response.body);

    if (body.isEmpty) {
      throw("Usuário não encontrado");
    }
    return UserLogged.fromMap(body[0]);
  }

  Future<UserLogged>signUp({@required Map<String, dynamic> userData}) async {
    http.Response response = await http
      .post("http://10.0.2.2:3000/users", body: userData);

    return UserLogged.fromMap(jsonDecode(response.body));
  }
}