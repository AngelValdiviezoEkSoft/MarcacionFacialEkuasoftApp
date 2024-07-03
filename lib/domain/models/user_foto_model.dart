import 'dart:convert';

class UserFotoModel {
  String user;
  String password;
  List modelData;

  UserFotoModel({
    required this.user,
    required this.password,
    required this.modelData,
  });

  static UserFotoModel fromMap(Map<String, dynamic> user) {
    return UserFotoModel(
      user: user['UserFotoModel'],
      password: user['password'],
      modelData: jsonDecode(user['model_data']),
    );
  }

  toMap() {
    return {
      'userFotoModel': user,
      'password': password,
      'model_data': jsonEncode(modelData),
    };
  }
}
