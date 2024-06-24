// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetarSenhaPerfil extends StatefulWidget {
  const ResetarSenhaPerfil({super.key});

  @override
  State<ResetarSenhaPerfil> createState() => _ResetarSenhaPerfilState();
}

class _ResetarSenhaPerfilState extends State<ResetarSenhaPerfil> {
  String? nome;
  late String token;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? '';
      if (nome!.isNotEmpty) {
        nome = utf8.decode(nome!.codeUnits);
      }
      token = prefs.getString('token') ?? '';
      if (token.isEmpty) {
        throw Exception('Token é nulo ou vazio');
      }
    });
  }

  Future<void> _salvarNovaSenha() async {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    UsuarioService usuarioService = UsuarioService();

    try {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: EdgeInsets.symmetric(vertical: 20),
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 3),
            content: AwesomeSnackbarContent(
              title: 'Atenção!',
              message: 'As senhas não coincidem.',
              messageFontSize: 15,
              contentType: ContentType.failure,
              color: const Color.fromARGB(255, 199, 44, 65),
              inMaterialBanner: false,
            ),
          ),
        );
        return;
      }

      await _loadPreferences();
      http.Response response =
          await usuarioService.changePassword(password, token);
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
              message: 'Senha redefinida com sucesso!',
              messageFontSize: 15,
              contentType: ContentType.success,
              color: const Color.fromARGB(255, 45, 106, 79),
              inMaterialBanner: false,
            ),
          ),
        );
        Navigator.pop(context, 'Sair');
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
            message: 'Erro ao redefinir a senha.',
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
        backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(233, 248, 255, 1),
          title: const Text('Redefinição de senha'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(1, 28, 57, 1)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: ListView(
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 40, top: 20),
                    child: Text(
                      '${nome?[0].toUpperCase()}${nome?.substring(1)}',
                      style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, bottom: 12),
                child: SizedBox(
                  child: Text(
                    'Informe sua nova senha',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(1, 28, 57, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 60, left: 60, bottom: 40),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Insira sua senha',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(1, 28, 57, 1),
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                    ),
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(1, 28, 57, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, bottom: 12),
                child: SizedBox(
                  child: Text(
                    'Confirme sua nova senha',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(1, 28, 57, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 60, left: 60),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Confirme sua senha',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(1, 28, 57, 1),
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(1, 28, 57, 1), width: 1.5),
                    ),
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(1, 28, 57, 1),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: ElevatedButton(
                  onPressed: () {
                    _salvarNovaSenha();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Salvar',
                        style: TextStyle(
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
        ));
  }
}
