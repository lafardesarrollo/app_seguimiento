import 'package:carwash_adm/src/helpers/helper.dart';
import 'package:carwash_adm/src/models/seguimiento.dart';
import 'package:carwash_adm/src/pages/detalle_seguimiento_page.dart';
import 'package:carwash_adm/src/pages/seguimiento_page.dart';
import 'package:carwash_adm/src/repository/seguimiento_repository.dart';
import 'package:carwash_adm/src/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  OverlayEntry loader;

  List<Seguimiento> lseguimiento = new List<Seguimiento>();
  String dropdownValue = 'Hoy';

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeController() {
    loader = Helper.overlayLoader(context);
    // listarReservas();
    // listarReservasInnerCurrent();
  }

  void getLocalization() async {
    final Stream<LocationData> stream = await obtenerLocalizacionActual();
    stream.listen((LocationData _locationData) {
      print("======OK");
      print(_locationData.latitude.toString());
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }

  void listenSeguimientoUsuario({String message}) async {
    final Stream<List<Seguimiento>> stream = await getSeguimientoPorUsuario();
    stream.listen((List<Seguimiento> _lseguimiento) {
      setState(() {
        lseguimiento = _lseguimiento;
      });
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener la información'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ));
      }
    });
  }

  void listenSeguimientoUsuarioFecha(String fecha) async {
    final Stream<List<Seguimiento>> stream =
        await getSeguimientoPorUsuarioFecha(fecha);
    stream.listen((List<Seguimiento> _lseguimiento) {
      setState(() {
        lseguimiento = _lseguimiento;
      });
    }, onError: (a) {
      print(a);
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('Ocurrio un error al obtener la información'),
      ));
    }, onDone: () {});
  }

  Future<void> abrirDetalleSeguimiento(Seguimiento _seguimiento) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleSeguimientoPage(
          seguimiento: _seguimiento,
        ),
      ),
    );
    if (resultado) {
      // this.listenSeguimientoUsuario(message: 'Se creo el nuevo registro!');
    } else {
      // print('No se actualizo el sistema');
    }
  }

  Future<void> abrirAgregarNuevo() async {
    final resultado = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SeguimientoPage()));
    if (resultado) {
      // this.listenSeguimientoUsuario(message: 'Se creo el nuevo registro!');
      this.listenSeguimientoUsuarioFecha("Hoy");
    } else {
      print('No se actualizo el sistema');
    }
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
