import 'package:carwash_adm/src/controllers/user_controller.dart';
import 'package:carwash_adm/src/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends StateMVC<SigninPage> {
  UserController _con;

  _SigninPageState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.username != null) {
      Navigator.of(context).pushReplacementNamed('/Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(top: 100),
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _con.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icon/logo.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '',
                          onSaved: (input) => _con.usuario.userid = input,
                          decoration: InputDecoration(
                            labelText: 'Nombre de Usuario',
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Nombre de Usuario',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            // prefixIcon:
                            //     Icon(Icons.email, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: '',
                          onSaved: (input) => _con.usuario.password = input,
                          obscureText: _con.hidePassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Contraseña',
                            labelStyle:
                                TextStyle(color: Theme.of(context).hintColor),
                            contentPadding: EdgeInsets.all(20),
                            hintText: '••••••••••••',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            // prefixIcon: Icon(
                            //   Icons.lock_outline,
                            //   color: Theme.of(context).accentColor,
                            // ),
                            suffixIcon: IconButton(
                              icon: Icon(_con.hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                setState(() {
                                  _con.hidePassword = !_con.hidePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1))),
                          ),
                        ),
                        SizedBox(height: 40),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 60,
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              _con.login();
                            },
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            color: Theme.of(context).hintColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
