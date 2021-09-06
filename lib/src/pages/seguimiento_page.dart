import 'package:carwash_adm/src/controllers/seguimiento_controller.dart';
import 'package:carwash_adm/src/models/seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SeguimientoPage extends StatefulWidget {
  // Seguimiento seguimiento;

  @override
  SeguimientoPageState createState() => SeguimientoPageState();
}

class SeguimientoPageState extends StateMVC<SeguimientoPage> {
  SeguimientoController _con;

  SeguimientoPageState() : super(SeguimientoController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Nuevo Registro',
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
            IconButton(
              icon: Icon(
                Icons.save_outlined,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                _con.checkMock();
              },
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Guardar Registro'),
          icon: Icon(Icons.save_outlined),
          onPressed: () {
            _con.checkMock();
          },
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Empleado: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            _con.seguimiento.nombreCompleto,
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fecha y Hora: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            _con.seguimiento.fechaHora.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(_con.seguimiento.latitud),
                      //     Text(_con.seguimiento.longitud)
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ubicación',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          MaterialButton(
                            child: _con.seguimiento.latitud.length > 2
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.red),
                                  ),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (cadena) {
                  print(cadena);
                  _con.seguimiento.descripcion = cadena;
                },
                decoration: InputDecoration(
                    labelText: 'Descripción del Lugar',
                    hintText: 'Descripción del Lugar',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 1.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(color: Theme.of(context).accentColor)),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (cadena) {
                  print(cadena);
                  _con.seguimiento.observaciones = cadena;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                    labelText: 'Observaciones',
                    hintText: 'Observaciones',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 1.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(color: Theme.of(context).accentColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
