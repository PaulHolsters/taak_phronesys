import 'dart:io';
import 'package:flutter/material.dart';

void main(){
 // HttpOverrides.global = MyHttpOverrides();
  runApp(const BoodschappenApp());
}

/*  class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
} */

class BoodschappenApp extends StatelessWidget {
  const BoodschappenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: PageWrapper()
    );
  }
}
