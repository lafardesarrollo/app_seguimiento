// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.userid,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.username,
    this.password,
    this.idCargo,
    this.cargo,
    this.idRegional,
    this.regional,
    this.idGrupo,
    this.idArea,
    this.area,
    this.foto,
    this.estado,
    this.nombreEstado,
    this.idSuperior,
    this.ubicacion,
    this.auth,
  });

  String userid;
  String firstName;
  String lastName;
  String emailAddress;
  String username;
  String password;
  String idCargo;
  String cargo;
  String idRegional;
  String regional;
  String idGrupo;
  String idArea;
  String area;
  String foto;
  String estado;
  String nombreEstado;
  String idSuperior;
  String ubicacion;
  bool auth;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        userid: json["userid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        username: json["username"],
        password: json["password"],
        idCargo: json["id_cargo"],
        cargo: json["cargo"],
        idRegional: json["id_regional"],
        regional: json["regional"],
        idGrupo: json["id_grupo"],
        idArea: json["id_area"],
        area: json["area"],
        foto: json["foto"],
        estado: json["estado"],
        nombreEstado: json["nombre_estado"],
        idSuperior: json["id_superior"],
        ubicacion: json["ubicacion"],
        auth: json["auth"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "username": username,
        "password": password,
        "id_cargo": idCargo,
        "cargo": cargo,
        "id_regional": idRegional,
        "regional": regional,
        "id_grupo": idGrupo,
        "id_area": idArea,
        "area": area,
        "foto": foto,
        "estado": estado,
        "nombre_estado": nombreEstado,
        "id_superior": idSuperior,
        "ubicacion": ubicacion,
        "auth": auth,
      };
}
