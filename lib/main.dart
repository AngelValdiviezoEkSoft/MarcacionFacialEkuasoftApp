import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marcacion_facial_ekuasoft_app/app/app.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';

void main() {
  setupServiceLocator();

  runApp( 
    const MarcacionFacial(),
    /*
    MultiBlocProvider(
      providers: [//
      
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => getIt<PinBloc>()),
        BlocProvider(create: (context) => getIt<SelectedConversationBloc>()),
        BlocProvider(create: (context) => getIt<ChatListBloc>()),
        BlocProvider(create: (context) => getIt<MessagesBloc>()),
        BlocProvider(create: (context) => getIt<ContactBloc>()),
        BlocProvider(create: (context) => getIt<GenericBloc>()),
        
      ],
      child: const ProviderScope(child: MarcacionFacial()),
    )
    */
  );
}