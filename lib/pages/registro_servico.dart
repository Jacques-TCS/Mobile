// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RegistroServico extends StatefulWidget {
  const RegistroServico({super.key, required int servicoId});

  @override
  State<RegistroServico> createState() => _RegistroServicoState();
}

class _RegistroServicoState extends State<RegistroServico> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // bottomNavigationBar: MenuInferior(currentIndex: widget.currentIndex),
        body: Text('Serviço'),
      ),
    );
  }
}
