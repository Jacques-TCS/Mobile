// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      ),
      body: Center(
        child: ListView(
          children: [
            // logo
            Image.asset("lib/images/logo.png", height: 240),

            // input usuario
            Padding(
              padding:
                  EdgeInsets.only(right: 60, left: 60, top: 60.0, bottom: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(
                    color: Colors.white,
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

            // input senha
            Padding(
              padding: EdgeInsets.only(right: 60, left: 60),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Colors.white,
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

            // botao esqueci a senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resetar_senha_login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Esqueci minha senha",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // botao entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 16),
                    Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
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
