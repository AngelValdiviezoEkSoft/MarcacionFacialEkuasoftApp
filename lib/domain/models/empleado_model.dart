
import 'dart:convert';

class EmpleadoModel {
    int id;
    String birthday;
    String gender;
    String privateStreet;
    String privateStreet2;
    String name;

    EmpleadoModel({
        required this.id,
        required this.birthday,
        required this.gender,
        required this.privateStreet,
        required this.privateStreet2,
        required this.name,
    });

    factory EmpleadoModel.fromRawJson(String str) => EmpleadoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
        id: json["id"] ?? 0,
        birthday: json["birthday"] ?? '',//json["birthday"] != null ? DateTime.parse(json["birthday"]) : DateTime.now(),
        gender: json["gender"] ?? '',
        privateStreet: json["private_street"] ?? '',
        privateStreet2: json["private_street2"] ?? '',
        name: json["name"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "birthday": birthday,//"${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "private_street": privateStreet,
        "private_street2": privateStreet2,
        "name": name,
    };
}
