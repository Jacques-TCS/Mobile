// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MenuInferior extends StatefulWidget {
  final int currentIndex;

  const MenuInferior({super.key, 
    required this.currentIndex,
  });

  @override
  State<MenuInferior> createState() => _MenuInferiorState();
}

class _MenuInferiorState extends State<MenuInferior> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (currentIndex) {
        if (currentIndex == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (currentIndex == 1) {
          Navigator.pushNamed(context, '/qrcode');
        } else if (currentIndex == 2) {
          Navigator.pushNamed(context, '/perfil');
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_2),
          label: 'QR Code',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

