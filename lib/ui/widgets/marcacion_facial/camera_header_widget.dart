import 'package:flutter/material.dart';

class CameraHeader extends StatelessWidget {
  const CameraHeader(Key? key, this.title, {this.onBackPressed}) : super(key: key);

  final String title;
  final void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      //color: Colors.transparent,
      width: size.width,
      height: 150,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.black, Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBackPressed,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 50,
              child: const Center(child: Icon(Icons.arrow_back)),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 90,
          )
        ],
      ),
    
    );
  }
}
