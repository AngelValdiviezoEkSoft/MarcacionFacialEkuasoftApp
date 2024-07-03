
import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({Key? key, required this.user}) : super(key: key);
  final UserFotoModel user;

  final _passwordController = TextEditingController();
  final _cameraService = getIt<CameraService>();

  Future _signIn(context, user) async {
    if (user.password == _passwordController.text) {
      Navigator.push(
        context, MaterialPageRoute(
          builder: (BuildContext context) => 
            ProfileScreen(
              user.user,
              imagePath: _cameraService.imagePath!,
            )
          )
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Wrong password!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.transparent,
            child: Text(              
              'Welcome back, ${user.user} .',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: 10),
                AppTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                AppButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    _signIn(context, user);
                  },
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
