// To parse this JSON data, do
//
//     final seguimiento = seguimientoFromJson(jsonString);

import 'dart:convert';

class LSeguimiento {
  List<Seguimiento> items = new List();
  LSeguimiento();
  LSeguimiento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final reserva = new Seguimiento.fromJson(item);
      items.add(reserva);
    }
  }
}

Seguimiento seguimientoFromJson(String str) =>
    Seguimiento.fromJson(json.decode(str));

String seguimientoToJson(Seguimiento data) => json.encode(data.toJson());

class Seguimiento {
  Seguimiento({
    this.id,
    this.username,
    this.nombreCompleto,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.fechaHora,
    this.observaciones,
  });

  String id;
  String username;
  String nombreCompleto;
  String descripcion;
  String latitud;
  String longitud;
  DateTime fechaHora;
  String observaciones;

  factory Seguimiento.fromJson(Map<String, dynamic> json) => Seguimiento(
        id: json["id"],
        username: json["username"],
        nombreCompleto: json["nombre_completo"],
        descripcion: json["descripcion"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
        observaciones: json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "nombre_completo": nombreCompleto,
        "descripcion": descripcion,
        "latitud": latitud,
        "longitud": longitud,
        "fecha_hora": fechaHora.toIso8601String(),
        "observaciones": observaciones,
      };
}
