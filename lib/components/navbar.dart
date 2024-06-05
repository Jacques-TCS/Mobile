// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/pages/agenda.dart';
import 'package:mobile/pages/perfil.dart';
import 'package:mobile/components/qrcode.dart';

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
        value: _statusBar(),
        child: Scaffold(
          body: _pageView(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          floatingActionButton: _floatingQrButton(),
          bottomNavigationBar: _bottomNavBar(),
        ),
      ),
    );
  }

  FloatingActionButton _floatingQrButton() {
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(220, 242, 252, 1),
      shape: CircleBorder(),
      onPressed: () {
        paginaController.jumpToPage(1);
      },
      elevation: 1,
      tooltip: 'Escaneie o QR Code',
      child: Icon(Icons.qr_code_2_rounded,
          color:
              paginaAtual == 1 ? Color.fromRGBO(12, 98, 160, 1) : Colors.grey),
    );
  }

  BottomAppBar _bottomNavBar() {
    return BottomAppBar(
      color: Color.fromRGBO(220, 242, 252, 1),
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //botao agenda
          Tooltip(
            message: 'Agenda',
            child: InkResponse(
              onTap: () {
                paginaController.jumpToPage(0);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event_note_rounded,
                      color: paginaAtual == 0
                          ? Color.fromRGBO(12, 98, 160, 1)
                          : Colors.grey),
                  Text("Agenda")
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 40)),

          // botao perfil
          Tooltip(
            message: 'Perfil',
            child: InkResponse(
              onTap: () {
                paginaController.jumpToPage(2);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_rounded,
                      color: paginaAtual == 2
                          ? Color.fromRGBO(12, 98, 160, 1)
                          : Colors.grey),
                  Text("Perfil")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PageView _pageView() {
    return PageView(
      controller: paginaController,
      children: [
        Agenda(paginaController: paginaController),
        QRCode(paginaController: paginaController),
        Perfil(),
      ],
      onPageChanged: (pagina) {
        setState(() {
          paginaAtual = pagina;
        });
      },
    );
  }

  SystemUiOverlayStyle _statusBar() {
    return SystemUiOverlayStyle(
      statusBarColor: paginaAtual == 1
          ? Colors.transparent
          : Color.fromRGBO(233, 248, 255, 1),
      statusBarIconBrightness:
          paginaAtual == 1 ? Brightness.light : Brightness.dark,
    );
  }
}
