// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class ResetarSenhaPerfil extends StatelessWidget {
  const ResetarSenhaPerfil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(233, 248, 255, 1),
              title: const Text('Redefinição de senha'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color.fromRGBO(1, 28, 57, 1)),
                onPressed: () {
                  // TODO
                },
              ),
            ),
            body: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, top: 32),
                      child: Icon(
                        Icons.person_rounded,
                        size: 120,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 60),
                      child: Text(
                        'Nome do usuário',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, bottom: 12),
                    child: SizedBox(
                        child: Text(
                          'Informe sua nova senha',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 28, 57, 1),
                            fontSize: 16,
                          ),
                        ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 60, left: 60, bottom: 40),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Insira sua senha',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          borderSide: const BorderSide(color:Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromRGBO(1, 28, 57, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, bottom: 12),
                    child: SizedBox(
                        child: Text(
                          'Confirme sua nova senha',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 28, 57, 1),
                            fontSize: 16,
                          ),
                        ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 60, left: 60),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Confirme sua senha',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          borderSide: const BorderSide(color:Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromRGBO(1, 28, 57, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Salvar', 
                          style: 
                          TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            color: Color.fromRGBO(1, 28, 57, 1),
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
                  )
                ],
              ),
            )));
  }
}
