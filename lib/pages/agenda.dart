// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(233, 248, 255, 1),
          title: const Text('Agenda'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              // mensagem boas vindas
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Bem-vindo, Fulano(a)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 28, 57, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ), 
                      ),
                    ),
                  ),
                ],
              ),

              // agenda
            ],
          ),
        ),
    );
  }
}