import 'dart:convert';
import 'dart:io';
import 'package:carwash_adm/src/models/reserva.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../helpers/custom_trace.dart';

/*Obtiene  reservas de acuerdo al cliente con datos de los vehiculos  */
// Future<Stream<List<Reserva>>> obtenerReservasdeHoy() async {
//   // Uri uri = Helper.getUriLfr('api/producto');
//   // String idcli = currentUser.value.uid; /*cambiar por id del cliente*/
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url_wash')}reserva/getnow';

//   final client = new http.Client();
//   final response = await client.get(url);
//   try {
//     if (response.statusCode == 200) {
//       final lreserva =
//           LReserva.fromJsonList(json.decode(response.body)['body']);
//       return new Stream.value(lreserva.items);
//     } else {
//       return new Stream.value(new List<Reserva>());
//     }
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: url).toString());
//     return new Stream.value(new List<Reserva>());
//   }
// }
