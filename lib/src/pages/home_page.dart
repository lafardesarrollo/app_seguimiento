import 'package:carwash_adm/src/controllers/home_controller.dart';
import 'package:carwash_adm/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage>
    with SingleTickerProviderStateMixin {
  Animation animationOpacity;
  AnimationController animationController;
  HomeController _con;
  double width_size;
  double height_size;

  _HomePageState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.getLocalization();
    // _con.listenSeguimientoUsuario();
    this._con.listenSeguimientoUsuarioFecha("Hoy");
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width_size = MediaQuery.of(context).size.width;
    height_size = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _con.scaffoldKey,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (context) => IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.bars,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 20),
                child: DropdownButton<String>(
                  value: _con.dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  onChanged: (String newValue) {
                    setState(() {
                      _con.dropdownValue = newValue;
                      // print(newValue);
                      _con.listenSeguimientoUsuarioFecha(newValue);
                    });
                  },
                  items: <String>['Hoy', 'Ultima Semana', 'Ultimo Mes', 'Todo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
              // IconButton(
              //   icon: Icon(
              //     Icons.refresh,
              //     color: Theme.of(context).primaryColor,
              //   ), // FaIcon(FontAwesomeIcons.syncAlt),
              //   onPressed: () {
              //     // _con.refreshHome();
              //   },
              // )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: ValueListenableBuilder(
              valueListenable: settingsRepo.setting,
              builder: (context, value, child) {
                return Text(
                  'Lafar Tracking',
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontSize: 18),
                );
              },
            ),
          ),
          drawer: DrawerWidget(),
          // drawer: Theme(
          //   data: Theme.of(context)
          //       .copyWith(canvasColor: Colors.transparent.withOpacity(0.5)),
          //   child: DrawerWidget(),
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _con.abrirAgregarNuevo();
              // final resultado = await Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SeguimientoPage()));
              // _con.getLocalization();
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: FaIcon(FontAwesomeIcons.calendarPlus),
          ),
          body: ListView.builder(
            itemCount: _con.lseguimiento.length,
            itemBuilder: (context, i) {
              final fecha_item = DateFormat("dd-MMM-yyyy hh:mm")
                  .format(_con.lseguimiento.elementAt(i).fechaHora);
              return InkWell(
                onTap: () {
                  _con.abrirDetalleSeguimiento(_con.lseguimiento.elementAt(i));
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Text((i + 1).toString()),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_con.lseguimiento.elementAt(i).descripcion),
                            Text(fecha_item)
                            // Text(_con.lseguimiento
                            //     .elementAt(i)
                            //     .fechaHora
                            //     .toIso8601String()),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right_outlined),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
