import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:marcacion_facial_ekuasoft_app/config/environments/environments.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/widgets/base_text_widget.dart';
import 'package:simple_shadow/simple_shadow.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class MarcacionScreen extends StatefulWidget {
  const MarcacionScreen({super.key});

  @override
  State<MarcacionScreen> createState() => _MarcacionScreenState();
}

//class MarcacionScreen extends StatelessWidget {
class _MarcacionScreenState extends State<MarcacionScreen> {

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  @override
  Widget build(BuildContext context) {

    /*
    context.read<ContactBloc>().add(LoadContactGeneralList());

    Future.delayed(const Duration(seconds: 2), () async {
      final objRutas = Rutas();

      bool authenticated = false;

      const storage = FlutterSecureStorage();
      final objEnvironmentProd = EnvironmentProd();

      //context.read<PinBloc>().add(ResetPin());
      //context.go('/enter_pin');

      //String isAuth = await storage.read(key: 'isAuthenticated') ?? '';
      String isPin = await storage.read(key: objEnvironmentProd.isPin) ?? '';
      String tieneToken = await storage.read(key: objEnvironmentProd.tokenApp) ?? '';

      if(tieneToken.isNotEmpty)
      {

        if(_supportState == _SupportState.unsupported || isPin == 'S'){
          context.read<PinBloc>().add(ResetPin());          
          context.go(objRutas.rutaEnterPin);
        }
        else {
          
          try{
            authenticated = await auth.authenticate(
              localizedReason: 'Identifíquese',
              options: const AuthenticationOptions(
                stickyAuth: true
              ),
            );
            
            if(authenticated) {
              Future.delayed(const Duration(milliseconds: 0), () {
                context.go(objRutas.rutaChats);
              });
            } else {
              Fluttertoast.showToast(
                msg: "Usuario no cuenta con permisos de acceso.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
          }
          catch(ex){
            //print(ex);
          }
          
          //await authenticate();
        }
      }
      
    });
    */

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: MainBackgroundWidget(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/friday_logomark.svg',
              ),
              const SizedBox(height: 30),
              SimpleShadow(
                opacity: 0.9,
                offset: const Offset(0, 4),
                sigma: 5,
                child: SvgPicture.asset(
                  'assets/icons/friday_logotext.svg',
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              Container(
                color: Colors.transparent,
                width: size.width * 0.65,
                child: GestureDetector(
                  onTap: () {
                    context.push(Rutas().rutaTomaFoto);
                  },
                  child: TextButtonMarcacion(
                    text: 'Realizar Marcación',
                    colorBoton: ColorsApp().morado,
                    colorTexto: Colors.white,
                    tamanioLetra: null,
                    tamanioBordes: null,
                    colorBordes: ColorsApp().morado,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
