import 'package:flutter/material.dart';
import 'package:mobile/components/menu_inferior.dart';

class QRCode extends StatefulWidget {
  const QRCode({super.key});
  final int currentIndex = 1;

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: MenuInferior(currentIndex: widget.currentIndex),
        body: Text('QRCode')
      ),
    );
  }
}
