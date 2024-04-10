import 'package:flutter/material.dart';
import 'package:mobile/components/menu_inferior.dart';

class Servico extends StatefulWidget {
  const Servico({super.key});
  // final int currentIndex = 0;

  @override
  State<Servico> createState() => _ServicoState();
}

class _ServicoState extends State<Servico> {
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
