// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jacques/pages/agenda.dart';
import 'package:jacques/components/navbar.dart';
import 'package:jacques/pages/login.dart';
import 'package:jacques/pages/perfil.dart';
import 'package:jacques/pages/qrcode.dart';
import 'package:jacques/pages/resetar_senha_login.dart';
import 'package:jacques/pages/resetar_senha_perfil.dart';
import 'package:jacques/pages/registro_servico.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/agenda': (context) => Agenda(paginaController: PageController()),
        '/perfil': (context) => Perfil(),
        '/qrcode': (context) => QRCode(paginaController: PageController()),
        '/resetar_senha_login': (context) => ResetarSenhaLogin(),
        '/resetar_senha_perfil': (context) => ResetarSenhaPerfil(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/servico') {
          final int servicoId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return RegistroServico(servicoId: servicoId);
            },
          );
        }
        return null;
      },
    );
  }
}
