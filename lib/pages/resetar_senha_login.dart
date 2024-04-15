// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class ResetarSenhaLogin extends StatelessWidget {
  const ResetarSenhaLogin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 28, 57, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(255, 255, 255, 1),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            // logo
            Image.asset("lib/images/logo.png", height: 240),
            Text("Redefinir Senha", 
              style: 
              TextStyle(
                color: Colors.white, 
                fontSize: 24, 
                fontWeight: FontWeight.bold
              ), 
            textAlign: TextAlign.center
            ),

            // input email
            Padding(
              padding:
                  EdgeInsets.only(right: 60, left: 60, top: 60.0, bottom: 60.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Informe seu e-mail',
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: const BorderSide(color:Colors.white, width: 1.5),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            // botao solicitar nova senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Solicitar nova senha",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
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
      ),
    );
  }
}
