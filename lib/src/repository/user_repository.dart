import 'dart:convert';
import 'dart:io';

import 'package:carwash_adm/src/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

ValueNotifier<Usuario> currentUser = new ValueNotifier(Usuario());

Future<Usuario> login(Usuario usuario) async {
  usuario.firstName = '';
  usuario.lastName = '';
  usuario.emailAddress = '';
  usuario.username = '';
  usuario.idCargo = '';
  usuario.cargo = '';
  usuario.idRegional = '';
  usuario.regional = '';
  usuario.idGrupo = '';
  usuario.idArea = '';
  usuario.area = '';
  usuario.foto = '';
  usuario.estado = '';
  usuario.nombreEstado = '';
  usuario.idSuperior = '';
  usuario.ubicacion = '';
  // print(json.encode(usuario.toMap()));
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}usuario/login';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(usuario.toJson()),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> responseJson = json.decode(response.body);
    print(responseJson['status']);
    if (responseJson['status'] == 404) {
      return null; //new Usuario();
    } else {
      setCurrentUser((response.body));
      currentUser.value =
          Usuario.fromJson(json.decode(response.body)['body'][0]);
    }
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

// Future<Usuario> register(Usuario user) async {
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}register';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(user.toMap()),
//   );
//   if (response.statusCode == 200) {
//     setCurrentUser(response.body);
//     currentUser.value = Usuario.fromJson(json.decode(response.body)['data']);
//   } else {
//     throw new Exception(response.body);
//   }
//   return currentUser.value;
// }

// Future<bool> resetPassword(Usuario user) async {
//   // return Future.delayed(Duration(seconds: 3)).then((value) => true);
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url_lfr')}cliente/reset/';
//   final client = new http.Client();
//   final response = await client.get(url + user.email);
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     throw new Exception(response.body);
//   }
// }

// Future<bool> changePassword(
//     String nuevo_password, String confirmar_password) async {
//   Usuario _user = userRepo.currentUser.value;

//   final String url =
//       '${GlobalConfiguration().getString('api_base_url_lfr')}cliente/updatepassword/${_user.id}/$nuevo_password';

//   final client = new http.Client();
//   final response = await client.get(url);
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<void> guardarTokenDevice(String token_device) async {
//   Usuario _user = userRepo.currentUser.value;
//   Cdev dev = new Cdev();
//   dev.id = 0;
//   dev.idCliente = _user.id;
//   dev.idDevice = token_device;
//   dev.estado = 1;
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url_lfr')}notificacion/guardartoken';
//   final client = new http.Client();
//   final response = await client.post(url,
//       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//       body: json.encode(dev));
//   // print(response.statusCode);
//   // if (response.statusCode == 200) {
//   //   print('=============================');
//   //   print('Se guardo el token correctamente');
//   // } else {
//   //   print('=============================');
//   //   print('No se pudo guardar el token');
//   // }
// }

// Future<void> iniciarNotificaciones() async {
//   FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
//   _firebaseMessaging.requestNotificationPermissions();
//   _firebaseMessaging.getToken().then((token) {
//     guardarTokenDevice(token);

//     // fhrcJlLJQ5i_VF4NUYpSTw:APA91bHkK9pJLbD7_xoAeX7u_bNmGMhKMKQNyk5cMTiqgKKvgCcworhqMut-CeKtC0IZeVtim7A7f8UdMmWb4TMr6BId1asIrMrj2NPoEBuQ_XHq260jZtlutEMLozWAL4OnoPYWh6RM
//   });

//   _firebaseMessaging.configure(
//     onMessage: (info) {
//       print('===================== On Message ====================');
//       print(info);
//       print(info['data']['id']);
//     },
//     onLaunch: (info) {
//       print('===================== On Launch ====================');
//       print(info);
//       print(info['data']['id']);
//     },
//     onResume: (info) {
//       print('===================== On Resume ====================');
//       print(info);

//       print(info['data']['id']);
//     },
//   );
// }

Future<void> logout() async {
  currentUser.value = new Usuario();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['body'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['body'][0]));
  }
}

Future<Usuario> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        Usuario.fromJson(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

// Future<Usuario> update(User user) async {
//   final String _apiToken = 'api_token=${currentUser.value.apiToken}';
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}users/${currentUser.value.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(user.toMap()),
//   );
//   setCurrentUser(response.body);
//   currentUser.value = Usuario.fromJson(json.decode(response.body)['data']);
//   return currentUser.value;
// }
