
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

String dirProsp = '';
ProspectoType? varObjProspecUbicReg;

String apiKeyMapaUbic = '';

ColorsApp objColoresAppMapaUbicacionReg = ColorsApp();

LatLng? objLatLngRecibido;

//ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  ProspectoType? varObjProspMap;
  String? direccionProspecto;
  String? apiKeyMapaUbic;

  MapScreen(Key? key, {varObjProspMap, direccionProspecto, apiKeyMapaUbic}) : super(key: key){
    if(varObjProspMap != null) {
      varObjProspecUbicReg = varObjProspMap;
    }

    if(direccionProspecto != '') {
      dirProsp = direccionProspecto;
    }

    if(apiKeyMapaUbic.isNotEmpty) {
      apiKeyMapaUbic = apiKeyMapaUbic;
    }
  }

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  ProspectoType? varObjProspect = varObjProspecUbicReg;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.stopFollowingUser();
  }
  
  @override
  Widget build(BuildContext context) {
    //const proximity = LatLng(-79.85266614975556,-2.2151049777572496);
    final searchBloc   = BlocProvider.of<SearchBloc>(context); 
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final size = MediaQuery.of(context).size;
    
    return WillPopScope(
      onWillPop: () async => false,
      child: ///dirProsp == '' ?
        
      Scaffold(
        
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            
            if (locationState.lastKnownLocation == null) {
              return const Center(child: Text('Espere por favor...')); 
            }
    
            return BlocBuilder<MapBloc, MapState>(
              builder: (context, mapState) {
    
                Map<String, Polyline> polylines = Map.from( mapState.polylines );
                
                if ( !mapState.showMyRoute ) {
                  polylines.removeWhere((key, value) => key == 'myRoute');
                }

                return BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, stateSearch) {
                    return BlocBuilder<SuscripcionBloc, SuscripcionState>(builder: (context, stateSuscripcion) {

                      if(stateSuscripcion.direccionUser.isNotEmpty && stateSearch.places.length - 1 >= 0) {
                        locationBloc.stopFollowingUser();
                        List<Feature> nuevaLista = [];
                        
                        for(int i = 0; i < stateSearch.places.length; i++) {
                          if(stateSearch.places[i].text != '' && stateSearch.places[i].text!.toLowerCase().contains(dirProsp) && nuevaLista.length - 1 < 0) {
                            nuevaLista.add(stateSearch.places[i]);
                            break;
                          }
                        }

                        if(nuevaLista.length - 1 < 0) {
                          objLatLngRecibido = null;
                        } else {
                          final result = SearchResult(
                            cancel: false,
                            manual: false,
                            position: LatLng(nuevaLista[0].center![1], nuevaLista[0].center![0]),
                            name: nuevaLista[0].text,
                            description: nuevaLista[0].placeName
                          );

                          if(stateSuscripcion.direccionUser.isEmpty && stateSearch.places.length - 1 < 0) {
                            searchBloc.add(AddToHistoryEvent(stateSearch.places[0]));
                          }

                          final userLocation = result.position;
                          objLatLngRecibido = userLocation;
                          mapBloc.moveCamera(userLocation!);
                        }
                      }

                        return SingleChildScrollView(
                        child: Stack(
                          children: [

                            MapView(
                              initialLocation: stateSuscripcion.direccionUser.isNotEmpty && objLatLngRecibido != null ? objLatLngRecibido! : locationState.lastKnownLocation!,
                              markers: mapState.markers.values.toSet(),
                              circleLlegada: const {},
                              llegadaLocation: const LatLng(0, 0),
                            ),

                            SearchBarWidget(null, varFiltroBusqueda: dirProsp, varApiKey: apiKeyMapaUbic),
                        
                            ManualMarker(null, varObjProspEnt: varObjProspect),

                            const Positioned(
                              top: 90,
                              left: 20,
                              child: BtnBackMapaUbicacionReg()
                            ),

                            Positioned(
                              bottom: size.height * 0.04,//70
                              left: size.width * 0.05,//37,
                              child: FadeInUp(
                                duration: const Duration( milliseconds: 300 ),
                                child: MaterialButton(
                                  minWidth: size.width * 0.9,
                                  color: objColoresAppMapaUbicacionReg.naranjaIntenso,
                                  elevation: 0,
                                  height: 50,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    final gpsBloc = BlocProvider.of<GpsBloc>(context);
                                  
                                    // Todo: loading
                                    final start = locationBloc.state.lastKnownLocation;
                                    if ( start == null ) return;

                                    final end = mapBloc.mapCenter;
                                    if ( end == null ) return;

                                    searchBloc.add(OnDeactivateManualMarkerEvent());

                                    //bool varTieneUbicacion = true;

                                    List<Placemark> placemarks = await placemarkFromCoordinates(end.latitude, end.longitude);
                                    final direccion = '${placemarks[0].country},${placemarks[0].locality},${placemarks[0].street}';

                                    gpsBloc.vuelvePantallaFrm(true,true,true); 
                                    
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("coordenadasIngreso",'${end.latitude},${end.longitude}');
                                    prefs.setString("direccionEscogida",'$direccion ');

                                    const storage = FlutterSecureStorage();
                                    String esEdicion = await storage.read(key: 'esEdicionData') ?? '';

                                    if(esEdicion.isNotEmpty && esEdicion == 'S') {
                                      /*
                                      Color coloresTextoRepuesta = Colors.transparent;
                                      Color coloresFondoRepuesta = Colors.transparent;

                                      if(objDataPersonalGen != null) {
                                        objDataPersonalGen!.longitud = end.longitude;
                                        objDataPersonalGen!.latitud = end.latitude;
                                      }
                                      */

                                      //String cedulaTmp = await storage.read(key: 'cedula') ?? '';

                                      /*                      
                                      ClientTypeResponse objRps = await UserFormService().editaDataPerfil(objDataPersonalGen!);
                                      
                                      if(objRps.succeeded) {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.green;
                                      } else {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.red;
                                      }

                                      Fluttertoast.showToast(
                                        msg: objRps.message,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: coloresFondoRepuesta,//Colors.red,
                                        textColor: coloresTextoRepuesta,//Colors.white,
                                        fontSize: 16.0
                                      );

                                      Future.microtask(() => Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => ActualizacionDatosScreen(varObjUserEnter: objUserActualizacionDatos),
                                          transitionDuration: const Duration(seconds: 0),
                                        ))
                                      );
                                      */
                                    }
                                    
                                  },
                                  child: const Text('Confirma tu ubicación', style: TextStyle( color: Colors.white, fontSize: 15 )),
                                ),
                              )
                            ),
                          
                          ],
                        ),
                      );
                      }
                    );
                  }
                );
              },
            );
          },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            /*
            BtnToggleUserRoute(),
            BtnFollowUser(),
            */
            //SizedBox(height: 50,),
            BtnCurrentLocation(),
          ],
        ),
      )
    
    );
  }


}

class BtnBackMapaUbicacionReg extends StatelessWidget {
  //ProspectoType? Obj_Prospecto;
  const BtnBackMapaUbicacionReg({
    Key? key,
    //Obj_Prospecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration( milliseconds: 300 ),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon( Icons.arrow_back_ios_new, color: Colors.black ),
          onPressed: () async {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("coordenadasIngreso",'');
            gpsBloc.vuelvePantallaFrm(false,true,true);

            // ignore: use_build_context_synchronously
            BlocProvider.of<SearchBloc>(context).add(
              OnDeactivateManualMarkerEvent()
            );

          },
        ),
      ),
    );
  }
}
