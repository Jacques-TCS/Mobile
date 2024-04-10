// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/pages/perfil.dart';
import 'package:mobile/pages/qrcode.dart';
import 'package:mobile/pages/servico.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/perfil': (context) => Perfil(),
        '/qrcode': (context) => QRCode(),
        '/servico': (context) => Servico(),
      },
    );
  }
}
