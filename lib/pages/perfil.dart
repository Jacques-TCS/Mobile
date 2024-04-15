// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(233, 248, 255, 1),
              title: const Text('Perfil'),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0.1
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color.fromRGBO(123, 210, 246, 1),
                      child: Icon(
                        Icons.person_rounded,
                        size: 120,
                        color: Color.fromRGBO(1, 28, 57, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 60, top: 20),
                      child: Text(
                        'Fulano',
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 20,
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      onPressed: () {
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
