// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:mobile/pages/servico.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile/services/servico_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Agenda extends StatefulWidget {
//   const Agenda({super.key, required this.paginaController});
//   final PageController paginaController;

//   @override
//   State<Agenda> createState() => _AgendaState();
// }

// class _AgendaState extends State<Agenda> {
//   int _expandedIndex = 0;

//   void _togglePanel(int index) {
//     setState(() {
//       if (_expandedIndex == index) {
//         _expandedIndex = -1;
//       } else {
//         _expandedIndex = index;
//       }
//     });
//   }

//   String? nome;

//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//   }

//   void _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       nome = prefs.getString('usuario') ?? '';
//       nome = utf8.decode(nome!.codeUnits);
//     });
//   }

//   final String _baseUrl='localhost:8080/api/servico/todos';
//   Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//   };

//   Future<List> getServicos() async {
//   try {
//     Uri uri = Uri.parse(_baseUrl);
//     http.Response response = await http.get(uri, headers: headers);
//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       List servicos = body.map((dynamic item) => Servico.fromJson(item)).toList();
//       return servicos;
//     } else {
//       throw Exception('Failed to load Servicos');
//     }
//   } catch (e) {
//     throw Exception('Failed to load Servicos');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
//         title: const Text('Agenda'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'Bem-vindo(a), $nome',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 color: const Color.fromRGBO(1, 28, 57, 1),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           ExpansionPanelList(
//             elevation: 0,
//             expandedHeaderPadding: EdgeInsets.zero,
//             expansionCallback: (int index, bool isExpanded) {
//               _togglePanel(index);
//             },
//             children: [
//               _servicosAbertos(context),
//               _servicosConcluidos(context),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   ExpansionPanel _servicosAbertos(BuildContext context) {
//     return ExpansionPanel(
//               backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
//               canTapOnHeader: true,
//               headerBuilder: (BuildContext context, bool isExpanded) {
//                 return Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       _togglePanel(0);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'TAREFAS DO DIA',
//                         style: TextStyle(
//                           color: const Color.fromRGBO(1, 28, 57, 1),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               body: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 child: FutureBuilder<List<Servico>>(
//                   future: getServicos() as Future<List<Servico>>?,
//                   builder: (BuildContext context, AsyncSnapshot<List<Servico>> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data?.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Servico servico = snapshot.data![index];
//                           return Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 AlertDialog alert = AlertDialog(
//                                   title: Text('Serviço ${index + 1}'),
//                                   content: Text('Limpeza Terminal: \n\n'
//                                       'Lista de Atividades: \n\n'
//                                       '1. Atividade 1\n'
//                                       '2. Atividade 2\n'
//                                       '3. Atividade 3\n\n'
//                                       'Deseja iniciar o serviço?'
//                                       ),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       onPressed: () =>
//                                           Navigator.pop(context, 'Cancel'),
//                                       child: const Text('Cancelar'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                         widget.paginaController.jumpToPage(1);
//                                       },
//                                       child: const Text('Escanear QR Code'),
//                                     ),
//                                   ],
//                                 );
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return alert;
//                                   },
//                                 );
//                               },
//                               child: Card(
//                                 child: ListTile(
//                                   title: Text(servico.name), // Replace with your actual Servico property
//                                   subtitle: Text(servico.description), // Replace with your actual Servico property
//                                   trailing: const Icon(Icons.arrow_drop_down_rounded),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//               isExpanded: _expandedIndex == 0,
//             );
//   }

//   ExpansionPanel _servicosConcluidos(BuildContext context) {
//     return ExpansionPanel(
//               backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
//               headerBuilder: (BuildContext context, bool isExpanded) {
//                 return Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       _togglePanel(1);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'TAREFAS CONCLUÍDAS',
//                         style: TextStyle(
//                           color: const Color.fromRGBO(1, 28, 57, 1),
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               body: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 20,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           AlertDialog alert = AlertDialog(
//                             title: Text('Serviço Realizado - ${index + 1}'),
//                             content: Text('Limpeza Terminal: \n\n'
//                                 'Lista de Atividades: \n\n'
//                                 '1. Atividade 1\n'
//                                 '2. Atividade 2\n'
//                                 '3. Atividade 3'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.pop(context, 'Sair'),
//                                 child: const Text('Sair'),
//                               ),
//                             ],
//                           );
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return alert;
//                             },
//                           );
//                         },
//                         child: Card(
//                           child: ListTile(
//                             title: Text('Agendamento ${index + 1}'),
//                             subtitle:
//                                 Text('Descrição do agendamento ${index + 1}'),
//                             trailing: const Icon(Icons.check_circle,
//                                 color: Colors.green),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               isExpanded: _expandedIndex == 1,
//             );
//   }
// }