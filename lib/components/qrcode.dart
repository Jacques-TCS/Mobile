// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile/components/qrcode_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCode extends StatefulWidget {
  final PageController paginaController;

  const QRCode({super.key, required this.paginaController});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromRGBO(1, 28, 57, 1),
        appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Color.fromRGBO(255, 255, 255, 1),),
            onPressed: () {
              widget.paginaController.jumpToPage(0);
            },
          ),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        ),
        body: Stack(
          children: [
            MobileScanner (
            controller: cameraController,
            onDetect: (barcodes) {
              },
            ),
            QRcodeOverlay(overlayColour: Colors.black.withOpacity(0.3))
          ]
        )
      ),
    );
  }
}
