import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
//import 'package:marcacion_facial_ekuasoft_app/app/app.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

import 'package:simple_shadow/simple_shadow.dart';
//import 'package:trust_location/trust_location.dart';

/*
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
*/

class MarcacionScreen extends StatefulWidget {
  const MarcacionScreen({super.key});

  @override
  State<MarcacionScreen> createState() => _MarcacionScreenState();
}

//class MarcacionScreen extends StatelessWidget {
class _MarcacionScreenState extends State<MarcacionScreen> {

  final LocalAuthentication auth = LocalAuthentication();
  //_SupportState _supportState = _SupportState.unknown;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    List<LocalidadType> lstLocalidades = [];
//-2.194379, -79.762934
    lstLocalidades.add(
      LocalidadType(
        codigo: '0123',
        descripcion: 'Test',
        esPrincipal: true,
        estado: '',
        fechaCreacion: DateTime.now(),
        id: '1',
        idEmpresa: '1',
        radio: 0.02,
        usuarioCreacion: '',
        usuarioModificacion: '',
        fechaModificacion: DateTime.now(),
        
        latitud: -2.194379,
        longitud: -79.762934
        
        /*
        latitud: -2.1510772,
        longitud: -79.8887465         
        */
        /*
        latitud: -2.151117,
        longitud: -79.889141
          
        */
        /*
        latitud: -2.194837,
        longitud: -79.763805
        */
      )
    );

    Color colorBtn = Colors.transparent;
    bool localizacionValida = false;

    return Scaffold(
      body: BlocBuilder<GenericBloc, GenericState>(
        builder: (context,state) {

          if(state.coordenadasMapa < state.radioMarcacion) {
            /*
            btnMarcacionFacial = '${objCadConMenuMarcaciones.endPointImagenes}btnMarcacionFacialActivo.png';
            btnMarcacionHuella = '${objCadConMenuMarcaciones.endPointImagenes}btnMarcacionHuellaActivo.png';
            */
            colorBtn = Colors.green;
            localizacionValida = true;
          } else {
            /*
            btnMarcacionFacial = '${objCadConMenuMarcaciones.endPointImagenes}btnMarcacionFacialInactivo.png';
            btnMarcacionHuella = '${objCadConMenuMarcaciones.endPointImagenes}btnMarcacionHuellaInactivo.png';
            */
            colorBtn = Colors.red;
            localizacionValida = false;
          }

          return MainBackgroundWidget(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SvgPicture.asset(
                    'assets/icons/friday_logomark.svg',
                  ),
          
                  SizedBox(height: size.height * 0.04,),
          
                  SimpleShadow(
                    opacity: 0.9,
                    offset: const Offset(0, 4),
                    sigma: 5,
                    child: SvgPicture.asset(
                      'assets/icons/friday_logotext.svg',
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.04,),
          
                  if(!isMockLocation)
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.92,
                    height: size.height * 0.45,
                    child: Scaffold( 
                      body: Opacity(
                        opacity: 1,
                        child: MarcacionMapScreen(null, lstLocalidad: lstLocalidades), 
                      ),
                    ),
                  ),
          
                  SizedBox(height: size.height * 0.04,),
          
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.65,
                    child: GestureDetector(
                      onTap: () async {
                        
                        //context.read<AuthBloc>().add(AppStarted());

                        /* 
                        var connectivityResult = await (Connectivity().checkConnectivity());
    
                          if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
                            emit(AuthNoInternet());
                          }
                        */

                        bool tomaFoto = true;
                        
                        var connectivityResult = await (Connectivity().checkConnectivity());
    
                        if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
                          tomaFoto = false;
                        }

                        if(tomaFoto && !isMockLocation) {
                          //ignore: use_build_context_synchronously
                          context.read<AuthBloc>().add(AppStarted());

                          //ignore: use_build_context_synchronously
                          context.push(Rutas().rutaTomaFoto);

                          return;
                        }

                        if(isMockLocation)
                        {
                          Fluttertoast.showToast(
                            msg: "No hagas trampa, usa tu ubicación real.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.yellow,
                            textColor: Colors.black,
                            fontSize: 16.0
                          );
                          return;
                        }

                        if(!localizacionValida){
                          Fluttertoast.showToast(
                            msg: "No se encuentra dentro de la localidad designada para marcar.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.yellow,
                            textColor: Colors.black,
                            fontSize: 16.0
                          );
                          return;
                        }
                        
                      },
                      child: TextButtonMarcacion(
                        text: 'Realizar Marcación',
                        colorBoton: colorBtn,//ColorsApp().morado,
                        colorTexto: Colors.white,
                        tamanioLetra: null,
                        tamanioBordes: null,
                        colorBordes: ColorsApp().morado,
                      ),
                    ),
                  ),
                
                  SizedBox(height: size.height * 0.02,),
          
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.65,
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(AppStarted());

                        final gpsBloc = BlocProvider.of<GpsBloc>(context);
                        gpsBloc.vuelveUbicacionNormal(false);

                        //
                        //context.push(Rutas().rutaDatosPersonalesOnBoarding);
                        context.push(Rutas().rutaDatosScanQrOnBoarding);
                      },
                      child: TextButtonMarcacion(
                        text: 'Registrate',
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
          );
        }
      ),
    );
  }
}
