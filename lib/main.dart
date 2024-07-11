import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marcacion_facial_ekuasoft_app/app/app.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';


void main() {
  setupServiceLocator();

  runApp( 
    MultiBlocProvider(
      providers: [//
      
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => getIt<GpsBloc>()),
        BlocProvider(create: (context) => getIt<LocationBloc>()),        
        BlocProvider(create: (context) => getIt<VerificacionBloc>()),
        BlocProvider(create: (context) => getIt<MapBloc>()),
        BlocProvider(create: (context) => getIt<GenericBloc>()),
        BlocProvider(create: (context) => getIt<SuscripcionBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        
      ],
      child: const ProviderScope(child: MarcacionFacial()),
    )
  );
}