import 'package:carwash_adm/src/helpers/helper.dart';
import 'package:carwash_adm/src/models/seguimiento.dart';
import 'package:carwash_adm/src/repository/seguimiento_repository.dart';
import 'package:carwash_adm/src/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trust_location/trust_location.dart';
import '../repository/user_repository.dart' as userRepo;

class SeguimientoController extends ControllerMVC {
  OverlayEntry loader;

  Seguimiento seguimiento = new Seguimiento();

  double latitud;
  double longitud;
  // List<Seguimiento> lseguimiento = new List<Seguimiento>();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  SeguimientoController() {
    loader = Helper.overlayLoader(context);
    cargarDatosIniciales();
    // listarReservas();
    // listarReservasInnerCurrent();
  }

  void cargarDatosIniciales() {
    setState(() {
      latitud = double.parse(seguimiento.latitud);
      longitud = double.parse(seguimiento.longitud);
    });

    this.seguimiento.id = "0";
    this.seguimiento.username = userRepo.currentUser.value.username;
    this.seguimiento.nombreCompleto = userRepo.currentUser.value.firstName +
        " " +
        userRepo.currentUser.value.lastName;
    this.seguimiento.fechaHora = DateTime.now();
    this.seguimiento.latitud = "0";
    this.seguimiento.longitud = "0";
    this.seguimiento.descripcion = "";
    this.seguimiento.observaciones = "NA";
    obtenerDateTime();
  }

  void getLocalization() async {
    final Stream<LocationData> stream = await obtenerLocalizacionActual();
    stream.listen((LocationData _locationData) {
      setState(() {
        this.seguimiento.latitud = _locationData.latitude.toString();
        this.seguimiento.longitud = _locationData.longitude.toString();
      });
    }, onError: (a) {
      print("====ON ERROR");
    }, onDone: () {
      print("====ON DONE");
    });
  }

  void obtenerDateTime() async {
    final Stream<String> stream = await getDateTime();
    stream.listen((String _fechaActual) {
      setState(() {
        getLocalization();
        this.seguimiento.fechaHora = DateTime.parse(_fechaActual);
      });
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> guardarRegistro() async {
    if (seguimiento.descripcion.length <= 1) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ingrese la descripción del lugar'),
        backgroundColor: Colors.red,
      ));
    } else {
      final Stream<bool> stream = await saveRegistroSeguimiento(seguimiento);
      stream.listen((bool _result) {
        setState(() {
          if (_result) {
            Navigator.pop(context, true);
          } else {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('No se pudo guardar. Intente nuevamente!'),
              backgroundColor: Colors.red,
            ));
          }
        });
      }, onError: (a) {}, onDone: () {});
    }
  }

  checkMock() async {
    final result = await TrustLocation.isMockLocation;
    if (result) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('No se permite realizar registros utilizando ubicación falsa'),
        backgroundColor: Colors.red,
      ));
    } else {
      this.guardarRegistro();
    }
  }

  // void listenSeguimientoUsuario({String message}) async {
  //   final Stream<List<Seguimiento>> stream = await getSeguimientoPorUsuario();
  //   stream.listen((List<Seguimiento> _lseguimiento) {
  //     lseguimiento = _lseguimiento;
  //     print(jsonEncode(lseguimiento));
  //   }, onError: (a) {
  //     print(a);
  //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //       content: Text('Ocurrio un error al obtener la información'),
  //     ));
  //   }, onDone: () {
  //     if (message != null) {
  //       scaffoldKey.currentState.showSnackBar(SnackBar(
  //         content: Text(message),
  //       ));
  //     }
  //   });
  // }

  // Future<void> abrirAgregarNuevo() async {
  //   final resultado = await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => SeguimientoPage()));
  //   if (resultado) {
  //     this.listenSeguimientoUsuario(message: 'Se creo el nuevo registro!');
  //   } else {
  //     print('No se actualizo el sistema');
  //   }
  // }

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
