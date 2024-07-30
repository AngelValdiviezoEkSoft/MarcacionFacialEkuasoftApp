import 'dart:convert';

import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

EmpleadoResponseModel empleadoResponseModelFromJson(String str) => EmpleadoResponseModel.fromJson(json.decode(str));

String empleadoResponseModelToJson(EmpleadoResponseModel data) => json.encode(data.toJson());

class EmpleadoResponseModel {
    bool success;
    String status;
    String message;
    int code;
    EmpleadoModel data;

    EmpleadoResponseModel({
        required this.success,
        required this.status,
        required this.message,
        required this.code,
        required this.data,
    });

    factory EmpleadoResponseModel.fromRawJson(String str) => EmpleadoResponseModel.fromJson(json.decode(str));

    factory EmpleadoResponseModel.fromJson(String str) =>
      EmpleadoResponseModel.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmpleadoResponseModel.fromMap(Map<String, dynamic> json) => EmpleadoResponseModel(
        success: json["success"] ?? false,
        status: json["status"] ?? '',
        message: json["message"] ?? '',
        code: json["code"] ?? 0,
        data: json["data"] != null ? EmpleadoModel.fromJson(json["data"])
        :
        EmpleadoModel(
          birthday: '',//DateTime.now(),
          gender: '',
          id: 0,
          name: '',
          privateStreet2: '',
          privateStreet: '',
        ),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "code": code,
        "data": data.toJson(),
    };
}
