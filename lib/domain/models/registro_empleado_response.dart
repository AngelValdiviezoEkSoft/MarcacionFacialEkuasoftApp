import 'dart:convert';

class RegistroEmpleadoResponseModel {
    String jsonrpc;
    int id;
    Result? result;

    RegistroEmpleadoResponseModel({
        required this.jsonrpc,
        required this.id,
        required this.result,
    });

    factory RegistroEmpleadoResponseModel.fromRawJson(String str) => RegistroEmpleadoResponseModel.fromJson(json.decode(str));

    factory RegistroEmpleadoResponseModel.fromJson(String str) =>
      RegistroEmpleadoResponseModel.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegistroEmpleadoResponseModel.fromMap(Map<String, dynamic> json) => RegistroEmpleadoResponseModel(
        jsonrpc: json["jsonrpc"] ?? '',
        id: json["id"] ?? 0,
        result: json["result"] != null ? 
          Result.fromMap(json["result"])
          :
          Result(
            code: 0,
            data: Data(),
            message: '',
            status: '',
            success: false
          ),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result!.toJson(),
    };
}

class Result {
    bool success;
    String status;
    String message;
    int code;
    Data data;

    Result({
        required this.success,
        required this.status,
        required this.message,
        required this.code,
        required this.data,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(String str) =>
      Result.fromMap(json.decode(str));

      /*
      factory RegistroEmpleadoResponseModel.fromJson(String str) =>
      RegistroEmpleadoResponseModel.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegistroEmpleadoResponseModel.fromMap(Map<String, dynamic> json) => RegistroEmpleadoResponseModel(
       */

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] != null 
          ? 
            Data.fromMap(json["data"])
            :
            Data(),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "code": code,
        "data": data.toJson(),
    };
}

class Data {
    Data();

    /*
    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());
    */

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    factory Data.fromJson(String str) =>
      Data.fromMap(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}
