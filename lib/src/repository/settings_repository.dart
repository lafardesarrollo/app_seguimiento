import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carwash_adm/src/helpers/custom_trace.dart';
import 'package:carwash_adm/src/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

final navigatorKey = GlobalKey<NavigatorState>();
//LocationData locationData;

Future<Setting> initSettings() async {
  Setting _setting;
  final String url =
      '${GlobalConfiguration().getString('api_base_url_lfr')}settings/get';
  try {
    final response = await http
        .get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      if (json.decode(response.body)['body'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'settings', json.encode(json.decode(response.body)['body'][0]));
        _setting = Setting.fromJSON(json.decode(response.body)['body'][0]);
        if (prefs.containsKey('language')) {
          _setting.mobileLanguage =
              new ValueNotifier(Locale(prefs.get('language'), ''));
        }
        setting.value = _setting;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    } else {
      print('else');
      print(CustomTrace(StackTrace.current, message: response.body[0])
          .toString());
    }
  } catch (e) {
    print('catch');
    print(CustomTrace(StackTrace.current, message: e).toString());
    return Setting.fromJSON({});
  }
  return setting.value;
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  brightness == Brightness.dark
      ? prefs.setBool("isDark", true)
      : prefs.setBool("isDark", false);
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language');
  }
  return defaultLanguage;
}

Future<void> saveMessageId(String messageId) async {
  if (messageId != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('google.message_id', messageId);
  }
}

Future<String> getMessageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('google.message_id');
}

// Guardar Automovil
Future<void> setAutomovil(String automovil) async {
  if (automovil != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('automovil', automovil);
  }
}

// Obtener Automovil
Future<String> getAutomovil() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('automovil');
}

Future<Stream<LocationData>> obtenerLocalizacionActual() async {
  Location location = new Location();
  LocationData _locationData;
  _locationData = await location.getLocation();

  return new Stream.value(_locationData);
}

// // Set Localización
// Future<String> setCurrentLocation() async {
//   var location = new Location();
//   location.requestService().then((value) async {
//     location.getLocation().then((_locationData) async {
//       print('==================***************===============');
//       print(_locationData);
//       return 'Ok';
//       // String _addressName = await mapsUtil.getAddressName(
//       //     new LatLng(_locationData?.latitude, _locationData?.longitude),
//       //     setting.value.googleMapsKey);
//       // _address = Address.fromJSON({
//       //   'address': _addressName,
//       //   'latitude': _locationData?.latitude,
//       //   'longitude': _locationData?.longitude
//       // });
//       // SharedPreferences prefs = await SharedPreferences.getInstance();
//       // await prefs.setString('delivery_address', json.encode(_address.toMap()));
//       // whenDone.complete(_address);
//     }).timeout(Duration(seconds: 10), onTimeout: () async {
//       print('Time OUT');
//       return 'Error TIme Out';
//       // SharedPreferences prefs = await SharedPreferences.getInstance();
//       // await prefs.setString('delivery_address', json.encode(_address.toMap()));
//       // whenDone.complete(_address);
//     }).catchError((e) {
//       return e.toString();
//       // whenDone.complete(_address);
//     });
//   });
