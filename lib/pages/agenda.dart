// ignore_for_file: prefer_const_constructors, avoid_print, body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/servico_model.dart';
import 'package:mobile/pages/registro_servico.dart';
import 'package:mobile/services/servico_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key, required this.paginaController});
  final PageController paginaController;

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  int _expandedIndex = 0;
  String? nome;
  late String token;
  Future<List<Servico>>? _allServicos;
  Future<List<Servico>>? _servicosAbertosHoje;

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((_) {
      _allServicos = getServicos(filterByDataHora: false);
      _servicosAbertosHoje = _allServicos?.then(
          (servicos) => servicos.where((s) => s.dataHoraFim == null).toList());
    }).catchError((error) {
      print('Erro ao buscar serviços: $error');
    });
  }

  void _togglePanel(int index) {
    if (mounted) {
      setState(() {
        _expandedIndex = (_expandedIndex == index) ? -1 : index;
      });
    }
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

  Map<String, String> get headers {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Servico>> getServicos({bool filterByDataHora = false}) async {
    try {
      await _loadPreferences();
      ServicoService servicoService = ServicoService();
      Map<String, String> params = {};
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        ...servicoService.headers,
      };

      http.Response response =
          await servicoService.get('/servicos-dia', params, requestHeaders);
      if (response.statusCode == 200) {
        List<Servico> servicos = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((item) => Servico.fromJson(item))
          .toList();

        if (filterByDataHora) {
          servicos =
              servicos.where((servico) => servico.dataHoraFim == null).toList();
        }

        return servicos;
      } else {
        throw Exception(
            'Falha ao carregar os serviços. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar serviços: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
      //   automaticallyImplyLeading: false,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 60.0, bottom: 32.0),
            child: Text(
              'Bem-vindo(a), ${nome?[0].toUpperCase()}${nome?.substring(1)}',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color.fromRGBO(1, 28, 57, 1),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              _togglePanel(index);
            },
            children: [
              _servicosAbertos(context),
              _servicosConcluidos(context),
            ],
          ),
        ],
      ),
    );
  }

  ExpansionPanel _servicosAbertos(BuildContext context) {
    return ExpansionPanel(
      backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _togglePanel(0);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<Servico>>(
                future: _servicosAbertosHoje,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Carregando...',
                      style: TextStyle(
                        color: const Color.fromRGBO(1, 28, 57, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Erro ao carregar serviços',
                      style: TextStyle(
                        color: const Color.fromRGBO(1, 28, 57, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    bool hasServicoEmAndamento = false;

                    // Check if any service is ongoing
                    for (Servico servico in snapshot.data!) {
                      if (servico.dataHoraInicio != null) {
                        hasServicoEmAndamento = true;
                        break;
                      }
                    }

                    String headerText = hasServicoEmAndamento
                        ? 'SERVIÇOS DO DIA - (1 em andamento)'
                        : 'SERVIÇOS DO DIA';

                    return Text(
                      headerText,
                      style: TextStyle(
                        color: const Color.fromRGBO(1, 28, 57, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return Text(
                      'SERVIÇOS DO DIA',
                      style: TextStyle(
                        color: const Color.fromRGBO(1, 28, 57, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
      body: FutureBuilder<List<Servico>>(
        future: _servicosAbertosHoje,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            double containerHeight = snapshot.data!.length * 100.0;
            double sizedBoxHeight = MediaQuery.of(context).size.height * 0.5;
            double finalHeight = min(containerHeight, sizedBoxHeight);
            return SizedBox(
              height: finalHeight,
              child: Column(
                children: [
                  if (snapshot.data!
                      .any((servico) => servico.dataHoraInicio != null))
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        children: snapshot.data!.map((servico) {
                          if (servico.dataHoraInicio != null) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RegistroServico(servicoId: servico.id),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    '${servico.ambiente.descricao}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text(servico.tipoDeLimpeza.tipoDeLimpeza),
                                  trailing: Icon(
                                    Icons.access_time_filled_rounded,
                                    color: Color.fromARGB(255, 255, 167, 67),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }).toList(),
                      ),
                    ),
                  if (snapshot.data!
                      .any((servico) => servico.dataHoraInicio != null))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        height: 2.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(12, 98, 160, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Servico servico = snapshot.data![index];
                        bool isServicoIniciado = servico.dataHoraInicio != null;
                        if (isServicoIniciado) {
                          return Container();
                        }
                        return Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AlertDialog alert = AlertDialog(
                                    title: Text(
                                      '${servico.ambiente.descricao}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    servico.tipoDeLimpeza
                                                        .tipoDeLimpeza,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Lista de atividades:',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    ' - ${servico.atividades.map((atividade) => atividade.descricao).join('\n - ')}',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Deseja iniciar o serviço?',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Color.fromRGBO(
                                                    12, 98, 160, 1),
                                              ),
                                              child: const Text('Cancelar'),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                widget.paginaController
                                                    .jumpToPage(1);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Color.fromRGBO(
                                                    12, 98, 160, 1),
                                              ),
                                              child: const Text('Ler QR Code'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          dialogBackgroundColor:
                                              Color.fromRGBO(220, 242, 252, 1),
                                        ),
                                        child: alert,
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.transparent,
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(
                                      '${servico.ambiente.descricao}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        servico.tipoDeLimpeza.tipoDeLimpeza),
                                    trailing: Icon(
                                      Icons.add_circle_rounded,
                                      color: Color.fromRGBO(12, 98, 160, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Nenhum serviço encontrado."));
          }
        },
      ),
      isExpanded: _expandedIndex == 0,
    );
  }

  ExpansionPanel _servicosConcluidos(BuildContext context) {
    return ExpansionPanel(
      backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _togglePanel(1);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'SERVIÇOS CONCLUÍDOS',
                style: TextStyle(
                  color: const Color.fromRGBO(1, 28, 57, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
      body: FutureBuilder<List<Servico>>(
        future: _allServicos?.then((servicos) =>
            servicos.where((s) => s.dataHoraFim != null).toList()),
        builder: (BuildContext context, AsyncSnapshot<List<Servico>> snapshot) {
          if (snapshot.hasData) {
            List<Servico> servicos = snapshot.data!
                .where((servico) => servico.dataHoraFim != null)
                .toList();
            if (servicos.isEmpty) {
              return Center(child: Text('Nenhum serviço concluído'));
            } else {
              double containerHeight = snapshot.data!.length * 100.0;
              double sizedBoxHeight = MediaQuery.of(context).size.height * 0.7;
              double finalHeight = min(containerHeight, sizedBoxHeight);
              return SizedBox(
                height: finalHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: servicos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Servico servico = servicos[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: Text('${servico.ambiente.descricao}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            content: SizedBox(
                              height: 200,
                              width: 300,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(servico.tipoDeLimpeza.tipoDeLimpeza,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 20),
                                    Text('Lista de atividades:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 10),
                                    Text(
                                        '  - ${servico.atividades.map((atividade) => atividade.descricao).join('\n  - ')}',
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              SizedBox(
                                width: 160,
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Sair'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color.fromRGBO(
                                        12, 98, 160, 1), // text color
                                  ),
                                  child: const Text('Sair'),
                                ),
                              ),
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Theme(
                                  data: Theme.of(context).copyWith(
                                      dialogBackgroundColor:
                                          Color.fromRGBO(220, 242, 252, 1)),
                                  child: alert);
                            },
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          elevation: 2,
                          child: ListTile(
                            title: Text('${servico.ambiente.descricao}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(servico.tipoDeLimpeza.tipoDeLimpeza),
                            trailing: const Icon(Icons.check_circle,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      isExpanded: _expandedIndex == 1,
    );
  }
}
