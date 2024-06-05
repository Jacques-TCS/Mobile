// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  String? nome;
  late String token;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

    Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('usuario') ?? '';
      if (nome!.isNotEmpty) {
        nome = utf8.decode(nome!.codeUnits);
      }
      token = prefs.getString('token') ?? '';
      if (token.isEmpty) {
        throw Exception('Token é nulo ou vazio');
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
            // appBar: AppBar(
            //   backgroundColor: Color.fromRGBO(233, 248, 255, 1),
            //   title: const Text('Perfil'),
            //   automaticallyImplyLeading: false,
            // ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: ProfilePicture(
                        name: '$nome',
                        radius: 60,
                        fontsize: 40,
                        count: 2,
                        
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 40, top: 20),
                      child: Text(
                        '$nome',
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 32,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Redefinição de senha',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 60),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/resetar_senha_perfil');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Alterar senha",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color.fromRGBO(123, 210, 246, 1),
                        foregroundColor: Color.fromRGBO(1, 28, 57, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 20),
                      child: Text(
                        'Sair do sistema',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('token');
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Sair', 
                          style: 
                          TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            color: Color.fromRGBO(1, 28, 57, 1),
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.logout_rounded, size: 24)
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color.fromRGBO(123, 210, 246, 1),
                        foregroundColor: Color.fromRGBO(1, 28, 57, 1),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
