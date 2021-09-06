import 'dart:async';
import 'dart:convert';

import 'package:carwash_adm/src/controllers/seguimiento_controller.dart';
import 'package:carwash_adm/src/models/seguimiento.dart';
import 'package:carwash_adm/src/pages/seguimiento_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DetalleSeguimientoPage extends StatefulWidget {
  Seguimiento seguimiento;

  DetalleSeguimientoPage({Key key, this.seguimiento}) {}

  @override
  DetalleSeguimientoPageState createState() => DetalleSeguimientoPageState();
}

class DetalleSeguimientoPageState extends StateMVC<DetalleSeguimientoPage> {
  SeguimientoController _con;
  GoogleMapController mapController;
  Set<Marker> markers = Set();
  Map<MarkerId, Marker> _markers = Map();

  DetalleSeguimientoPageState() : super(SeguimientoController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    _con.seguimiento = widget.seguimiento;
    super.initState();
  }

  _goToUbicacion() {
    final CameraPosition kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(_con.latitud, _con.longitud),
        zoom: 17);
    mapController.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  _setMarker(LatLng p) {
    final markerId = MarkerId('${_con.seguimiento.id}');
    final marker = Marker(markerId: markerId, position: p);
    setState(() {
      _markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalle de Registro',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.save_outlined,
//                 color: Theme.of(context).primaryColor,
//               ),
//               onPressed: () {
// //                 _con.checkMock();
//               },
//             )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor.withOpacity(0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, -2)),
            ],
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _con.seguimiento.descripcion,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _con.seguimiento.fechaHora.toString(),
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w100),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text(
                  _con.seguimiento.observaciones.toString(),
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 16),
          onMapCreated: (GoogleMapController controller) {
            print('EL mapa esta cargado');
            print(jsonEncode(widget.seguimiento));
            setState(() {
              _con.latitud = double.parse(widget.seguimiento.latitud);
              _con.longitud = double.parse(widget.seguimiento.longitud);

              Future.delayed(Duration(seconds: 1), () {
                _goToUbicacion();
              });
            });
            mapController = controller;
            _setMarker(LatLng(_con.latitud, _con.longitud));
          },
          markers: Set.of(_markers.values),
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     _goToUbicacion();
        //   },
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }
}
