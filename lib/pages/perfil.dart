import 'package:flutter/material.dart';
import 'package:mobile/components/menu_inferior.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});
  final int currentIndex = 2;

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: MenuInferior(currentIndex: widget.currentIndex),
        body: Text('Perfil'),
      ),
    );
  }
}
