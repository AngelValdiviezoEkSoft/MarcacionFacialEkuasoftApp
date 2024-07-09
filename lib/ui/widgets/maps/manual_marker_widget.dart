
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProspectoType? objProspecMarker;

//ignore: must_be_immutable
class ManualMarker extends StatelessWidget {
  ProspectoType? varObjProspEnt;
  ProspectoType? varObjProspecto;
  ManualMarker(Key? key, {varObjProspEnt}) : super(key: key){
    varObjProspecto = varObjProspEnt;
    objProspecMarker = varObjProspEnt;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return const ManualMarkerBody();
         //Para cuando se quiera hacer uso del mapa como en uber
        /*
        return state.displayManualMarker 
            ? _ManualMarkerBody(ObjProsp: Obj_Prospecto)
            : const SizedBox();
            */

      },
    );
  }
}




class ManualMarkerBody extends StatelessWidget {
  
  const ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    //final searchBloc = BlocProvider.of<SearchBloc>(context);
    //final locationBloc = BlocProvider.of<LocationBloc>(context);
    //final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          
          const Positioned(
            top: 90,
            left: 20,
            child: BtnBackManualMarker()
          ),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22 ),
              child: BounceInDown(
                from: 100,
                child: Container(    
                  width: 65,
                  height: 65,
                  //color: Colors.transparent,
                  decoration: const BoxDecoration(
                    
                    image: DecorationImage(
                        image: AssetImage('assets/PinRegistro.png'), 
                        //fit: BoxFit.cover,
                    ),
                    
                   // color: Colors.black
                  ),
                  )//const Icon( Icons.location_on_rounded, size: 60 )
              ),
            ),
          ),

/*
          // Boton de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration( milliseconds: 300 ),
              child: MaterialButton(
                minWidth: size.width * 0.8,
                color: Colors.orange[700],
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                onPressed: () async {
                
                  // Todo: loading

                  final start = locationBloc.state.lastKnownLocation;
                  if ( start == null ) return;

                  final end = mapBloc.mapCenter;
                  if ( end == null ) return;

                  //showLoadingMessage(context);
/*

                  final destination = await searchBloc.getCoorsStartToEnd(start, end);
                  
                  await mapBloc.drawRoutePolyline(destination);
                  
                  searchBloc.add( OnDeactivateManualMarkerEvent());
                  */
                  //print('Coordenadas: $end');
                  //var loc = locationBloc.state;
                  //Navigator.pop(context);

                  searchBloc.add( OnDeactivateManualMarkerEvent());

                  bool TieneUbicacion = false;

                  if(end != null) {
                    TieneUbicacion = true;
                  }

                  final gpsBloc = BlocProvider.of<GpsBloc>(context);
                  gpsBloc.VuelvePantallaFrm(TieneUbicacion,true,true);

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("coordenadasIngreso",'${end.latitude},${end.longitude}');
                  
                },
                child: const Text('Confirma tu ubicación', style: TextStyle( color: Colors.white, fontSize: 15 )),
              ),
            )
          ),
*/
        ],
      ),
    );
  }
}

class BtnBackManualMarker extends StatelessWidget {
  const BtnBackManualMarker({
    Key? key,
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
            /* //Para cuando se quiera hacer uso del mapa como en uber
            BlocProvider.of<SearchBloc>(context).add(
              OnDeactivateManualMarkerEvent()
            );
            */
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //final coordElegidas = prefs.getString("coordenadasIngreso");
            prefs.setString("coordenadasIngreso",'');
            
            gpsBloc.vuelvePantallaFrm(false,true,true);
          },
        ),
      ),
    );
  }
}
