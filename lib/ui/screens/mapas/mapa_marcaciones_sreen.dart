
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
//import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:provider/provider.dart';

String? varLatitude;
String? varLongitude;
bool isMockLocation = false;
bool esUsuarioValidoMarcacion = false;

double latLlegada = 0;//-2.1409825968652996;
double lonLlegada = 0;//-79.93258100251383;
List<LocalidadType>? lstLocalidad;
List<LocalidadType>? lstLocalidadVerifica;

class MarcacionMapScreen extends StatefulWidget {
  

  MarcacionMapScreen(Key? key,{lstLocalidad}) : super(key: key){
    
    if(lstLocalidad != null) {
      lstLocalidadVerifica = lstLocalidad;
    }
  }

  @override
  State<MarcacionMapScreen> createState() => _MarcacionMapScreenState();
}

class _MarcacionMapScreenState extends State<MarcacionMapScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Provider.of<LocalidadService>(context).obtenerLocalidadMarcacion('');
    //List<LocalidadType> listaLocalidades = Provider.of<LocalidadService>(context).listaLocalidades;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(        
        body: BlocBuilder<GenericBloc, GenericState>(
          builder: (context, colorState) {
            return BlocBuilder<LocationBloc, LocationState>(
              builder: (context, locationState) { 
              
                if (locationState.lastKnownLocation == null) { 
                  final varPosicionInicial = BlocProvider.of<GenericBloc>(context);
                  varPosicionInicial.setPosicionMapa(1);
                  return const Center(child: Text(' ')); 
                } 

                return BlocBuilder<MapBloc, MapState>(
                  builder: (context, mapState) {
      
      /*
                  Map<String, Polyline> polylines = Map.from( mapState.polylines );
                  if ( !mapState.showMyRoute ) {
                    polylines.removeWhere((key, value) => key == 'myRoute');
                  }
                  */

                  double respDistancia = 0;
                  final posicionInicial = BlocProvider.of<GenericBloc>(context);

                  for(int i = 0; i < lstLocalidadVerifica!.length; i++) {
                    respDistancia = calculateDistance(locationState.lastKnownLocation!.latitude,locationState.lastKnownLocation!.longitude,lstLocalidadVerifica?[i].latitud ?? 0,lstLocalidadVerifica?[i].longitud ?? 0,);
                    latLlegada = lstLocalidadVerifica?[i].latitud ?? 0;
                    lonLlegada = lstLocalidadVerifica?[i].longitud ?? 0;
                    posicionInicial.setLocalidadId(lstLocalidadVerifica?[i].id ?? '');
                    posicionInicial.setRadioMarcacion(lstLocalidadVerifica![i].radio);
                    /*
                    if(respDistancia < lstLocalidadVerifica![i].radio) {
                      latLlegada = lstLocalidadVerifica?[i].latitud ?? 0;
                      lonLlegada = lstLocalidadVerifica?[i].longitud ?? 0;                      
                      posicionInicial.setLocalidadId(lstLocalidadVerifica?[i].id ?? '');
                      posicionInicial.setRadioMarcacion(lstLocalidadVerifica![i].radio);
                      if(lstLocalidadVerifica!.length - 1 == 0) {
                        posicionInicial.setFormaPago(lstLocalidadVerifica![i].codigo);
                      }
                      break;
                    }
                    */
                  }

                  if(lstLocalidadVerifica!.length - 1 >= 0) {
                    String msnMostrar = '';
                    for(int i = 0; i < lstLocalidadVerifica!.length; i++) {
                      if(msnMostrar == '') {
                        msnMostrar = lstLocalidadVerifica![i].codigo;
                      } else {
                        msnMostrar = '$msnMostrar o en ${lstLocalidadVerifica![i].codigo}';
                      }
                    }
                    posicionInicial.setFormaPago(msnMostrar);
                  }

                  posicionInicial.setPosicionMapa(respDistancia);
                  
                  final marcadorDestino = Marker(
                    markerId: const MarkerId('end'),
                    position: LatLng(latLlegada,lonLlegada),
                    //icon: 'Icons.map',//Para cambiar el ícono
                  );
                  
                  Set<Circle> circleLst = Set<Circle>.from([
                    Circle(
                      circleId: const CircleId('1'),
                      center: LatLng(latLlegada, lonLlegada),
                      radius: posicionInicial.radioMarcacion * 1000,
                      fillColor: Colors.transparent,
                      strokeColor: const Color.fromARGB(255, 254, 90, 0),
                      strokeWidth: 1
                    )
                  ]);
                  
                  final marcadorFinal = Map<String, Marker>.from(mapState.markers);
                  marcadorFinal['end'] = marcadorDestino;
      
                  return SingleChildScrollView(
                        child: Stack(
                          children: [
                            
                            MapView(
                              initialLocation: locationState.lastKnownLocation!,
                              markers: marcadorFinal.values.toSet(),
                              circleLlegada: circleLst,
                              llegadaLocation: LatLng(latLlegada, lonLlegada),
                            ),
                            
                          ],
                        ),
                      );
                    
                },
              );
              
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BtnCurrentLocation(),
          ],
        ),
      )
    );
  }


}

double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p))/2;
  
  return 12742 * asin(sqrt(a));
}
