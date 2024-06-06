// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RegistroServico extends StatefulWidget {
  final int servicoId;

  const RegistroServico({super.key, required this.servicoId});

  @override
  State<RegistroServico> createState() => _RegistroServicoState();
}

class _RegistroServicoState extends State<RegistroServico> {
  @override
  Widget build(BuildContext context) {
    int servicoId = widget.servicoId; 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Text('Serviço: $servicoId'),
      ),
    );
  }
}