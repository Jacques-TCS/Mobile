// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/usuario_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:mobile/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  Usuario usuario = Usuario(username: '', password: '');
  UsuarioService usuarioService = UsuarioService();

  Future save() async {
    if (usuario.username != null && usuario.password != null) {
      var res =
          await usuarioService.login(usuario.username!, usuario.password!);
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        if (body['perfil'] == "Colaborador") {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('usuario', body['username']);
          prefs.setString('token', body['token']);
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              padding: EdgeInsets.symmetric(vertical: 20),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              duration: Duration(seconds: 3),
              content: AwesomeSnackbarContent(
                title: 'Atenção!',
                message: 'Acesso restrito a colaboradores.',
                messageFontSize: 15,
                contentType: ContentType.failure,
                color: const Color.fromARGB(255, 199, 44, 65),
                inMaterialBanner: false,
              ),
            ),
          );
        }
      } else {
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
                  'Usuário ou senha inválidos. Por favor, tente novamente.',
              messageFontSize: 15,
              contentType: ContentType.failure,
              color: const Color.fromARGB(255, 199, 44, 65),
              inMaterialBanner: false,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 28, 57, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("lib/images/logo.png", height: 240),
                _inputUsuario(),
                _inputSenha(),
                _botaoEsqueciSenha(context),
                _botaoLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _inputUsuario() {
    return Padding(
      padding: EdgeInsets.only(right: 60, left: 60, top: 60.0, bottom: 20.0),
      child: TextFormField(
        controller: TextEditingController(text: usuario.username),
        onChanged: (value) {
          usuario.username = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu usuário';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Usuário',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Padding _inputSenha() {
    return Padding(
      padding: EdgeInsets.only(right: 60, left: 60),
      child: TextFormField(
        obscureText: true,
        controller: TextEditingController(text: usuario.password),
        onChanged: (val) {
          usuario.password = val;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira sua senha';
          }
          return null;
        },
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: 'Senha',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Padding _botaoEsqueciSenha(BuildContext context) {
    return Padding(
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
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Padding _botaoLogin() {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, right: 80.0, bottom: 120.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            save();
          }
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
    );
  }
}
