import 'dart:convert';

import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

class LocalidadTypeResponse {
    LocalidadTypeResponse({
      required this.succeeded,
      required this.message,
      required this.statusCode,
      required this.errors,
      required this.data,
    });

    bool succeeded;
    String message;
    String statusCode;
    Errors errors;
    List<LocalidadType> data;

    factory LocalidadTypeResponse.fromJson(String str) => LocalidadTypeResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LocalidadTypeResponse.fromMap(Map<String, dynamic> json) => LocalidadTypeResponse(
        succeeded: json["succeeded"],
        message: json["message"],
        statusCode: json["statusCode"],
        errors: Errors.fromMap(json["errors"]),
        data: List<LocalidadType>.from(json["data"].map((x) => LocalidadType.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "succeeded": succeeded,
        "message": message,
        "statusCode": statusCode,
        "errors": errors.toMap(),
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}
