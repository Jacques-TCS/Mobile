// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/usuario_service.dart';
import 'package:http/http.dart' as http;

class ResetarSenhaLogin extends StatefulWidget {
  const ResetarSenhaLogin({super.key});

  @override
  State<ResetarSenhaLogin> createState() => _ResetarSenhaLoginState();
}

class _ResetarSenhaLoginState extends State<ResetarSenhaLogin> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetarSenha() async {
    String email = _emailController.text;
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 3),
          content: AwesomeSnackbarContent(
            title: 'Atenção!',
            message: 'Por favor, insira um e-mail válido.',
            messageFontSize: 15,
            contentType: ContentType.failure,
            color: const Color.fromARGB(255, 199, 44, 65),
            inMaterialBanner: false,
          ),
        ),
      );
      return; 
    }

    UsuarioService usuarioService = UsuarioService();

    try {
      http.Response response = await usuarioService.resetPassword(email);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: EdgeInsets.symmetric(vertical: 20),
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 3),
            content: AwesomeSnackbarContent(
              title: 'Sucesso!',
              message: 'Email de recuperação enviado!',
              messageFontSize: 15,
              contentType: ContentType.success,
              color: const Color.fromARGB(255, 45, 106, 79),
              inMaterialBanner: false,
            ),
          ),
        );
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 3),
          content: AwesomeSnackbarContent(
            title: 'Atenção!',
            message:
                'Erro ao enviar email de recuperação. Verifique se seu e-mail está correto.',
            messageFontSize: 15,
            contentType: ContentType.failure,
            color: const Color.fromARGB(255, 199, 44, 65),
            inMaterialBanner: false,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 28, 57, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),

            // input email
            Padding(
              padding:
                  EdgeInsets.only(right: 60, left: 60, top: 60.0, bottom: 60.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Informe seu e-mail',
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
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
                  _resetarSenha();
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
