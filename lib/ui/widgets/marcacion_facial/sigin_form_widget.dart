
import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';

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
          return const AlertDialog(
            content: Text('Contraseña incorrecta!'),
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
                const SizedBox(height: 10),
                AppTextField(
                  controller: _passwordController,
                  labelText: "Clave",
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                AppButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    _signIn(context, user);
                  },
                  icon: const Icon(
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
