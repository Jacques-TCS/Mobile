// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/pages/agenda.dart';
import 'package:mobile/pages/perfil.dart';
import 'package:mobile/components/qrcode.dart';
import 'package:mobile/pages/resetar_senha_perfil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int paginaAtual = 0;
  late PageController paginaController;

  @override
  void initState() {
    super.initState();
    paginaController = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(233, 248, 255, 1),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            body: PageView(
              controller: paginaController,
              children: [
                Agenda(),
                QRCode(),
                Perfil(),
                ResetarSenhaPerfil(),
              ],
              onPageChanged: (pagina) {
                setState(() {
                  paginaAtual = pagina;
                });
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(220, 242, 252, 1),
              shape: CircleBorder(),
              onPressed: () {
                paginaController.jumpToPage(1);
              },
              elevation: 1,
              tooltip: 'Escaneie o QR Code',
              child: Icon(Icons.qr_code_2_rounded, color: paginaAtual == 1 ? Color.fromRGBO(12, 98, 160, 1) : Colors.grey),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Color.fromRGBO(220, 242, 252, 1),
              shape: CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  InkResponse(
                    onTap: () {
                      paginaController.jumpToPage(0);
                    },
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                      children:[
                        Icon(Icons.event_note_rounded, color: paginaAtual == 0 ? Color.fromRGBO(12, 98, 160, 1) : Colors.grey),
                        Text("Agenda")
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 40)),
                  InkResponse(
                    onTap: () {
                      paginaController.jumpToPage(2);
                    },
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                      children:[
                        Icon(Icons.person_rounded, color: paginaAtual == 2 ? Color.fromRGBO(12, 98, 160, 1) : Colors.grey),
                        Text("Perfil")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: paginaAtual != 1 ? Color.fromRGBO(233, 248, 255, 1) : Color.fromRGBO(233, 248, 255, 1).withOpacity(0),
          ),
      ),
    );
  }
}