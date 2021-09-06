import 'package:carwash_adm/src/helpers/helper.dart';
import 'package:carwash_adm/src/models/reserva.dart';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ReservaController extends ControllerMVC {
  OverlayEntry loader;

  Reserva reserva;
  List<Reserva> lreservas = [];

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ReservaController() {
    loader = Helper.overlayLoader(context);
    // listarReservas();
    // listarReservasInnerCurrent();
  }

  //listar reservas de hoy
  // void listarReservas({String message}) async {
  //   FocusScope.of(context).unfocus();
  //   Overlay.of(context).insert(loader);

  //   final Stream<List<Reserva>> stream = await obtenerReservasdeHoy();
  //   stream.listen((List<Reserva> _reservas) {
  //     setState(() {
  //       lreservas = _reservas;
  //       // print("===============================");
  //       // // //print(carros);
  //       // print(jsonEncode(lreservas));
  //     });
  //   }, onError: (a) {
  //     // loader.remove();
  //     scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener las reservas'),
  //     ));
  //   }, onDone: () {
  //     // Helper.hideLoader(loader);
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }
}
