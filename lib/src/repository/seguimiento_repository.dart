import 'dart:convert';
import 'dart:io';
import 'package:carwash_adm/src/models/reserva.dart';
import 'package:carwash_adm/src/models/seguimiento.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/user_repository.dart' as userRepo;

import 'package:http/http.dart' as http;

import '../helpers/custom_trace.dart';

/*Obtiene  reservas de acuerdo al cliente con datos de los vehiculos  */
Future<Stream<List<Seguimiento>>> getSeguimientoPorUsuario() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}seguimiento/get/' +
          userRepo.currentUser.value.username;

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final lseguimiento =
          LSeguimiento.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lseguimiento.items);
    } else {
      return new Stream.value(new List<Seguimiento>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Seguimiento>());
  }
}

/*Obtiene  información de seguimiento por fecha y usuario  */
Future<Stream<List<Seguimiento>>> getSeguimientoPorUsuarioFecha(
    String fecha) async {
  Map<String, dynamic> datos = new Map<String, dynamic>();
  datos = {"username": userRepo.currentUser.value.username, "fecha": fecha};
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}seguimiento/getinfo';

  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(datos),
  );
  try {
    if (response.statusCode == 200) {
      final lseguimiento =
          LSeguimiento.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(lseguimiento.items);
    } else {
      return new Stream.value(new List<Seguimiento>());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new List<Seguimiento>());
  }
}

Future<Stream<bool>> saveRegistroSeguimiento(Seguimiento seguimiento) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}seguimiento/save';

  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(seguimiento.toJson()),
  );
  try {
    if (response.statusCode == 200) {
      // final lseguimiento = LSeguimiento.fromJsonList(json.decode(response.body)['body']);
      return new Stream.value(true);
    } else {
      return new Stream.value(false);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(false);
  }
}

Future<Stream<String>> getDateTime() async {
  final nuevaFecha = DateTime.now().toString();
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}marcacion/getdatetime';

  final client = new http.Client();
  final response = await client.get(url);
  try {
    if (response.statusCode == 200) {
      final fechaActual = json.decode(response.body)['body'];
      return new Stream.value(fechaActual);
    } else {
      return new Stream.value(nuevaFecha);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(nuevaFecha);
  }
}
