
import 'package:flutter/material.dart';

class GpsErrorScreen extends StatefulWidget {

  const GpsErrorScreen(Key? key) : super (key: key);

  @override
  State<GpsErrorScreen> createState() => _GpsErrorScreenState();
}

class _GpsErrorScreenState extends State<GpsErrorScreen> {
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.red,
      width: size.width,
      height: size.height * 0.2,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text('Debe habilitar el GPS',style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),),
        
        ],
      )
    
    );
  }
}