// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/categoria_de_ocorrencia_model.dart';
import 'package:mobile/models/servico_model.dart';
import 'package:mobile/services/categoria_de_ocorrencia_service.dart';
import 'package:mobile/services/servico_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroServico extends StatefulWidget {
  final int servicoId;

  const RegistroServico({super.key, required this.servicoId});

  @override
  State<RegistroServico> createState() => _RegistroServicoState();
}

class _RegistroServicoState extends State<RegistroServico> {
  String? nome;
  late String token;
  late Future<Servico> servicoFuture;
  late Future<List<CategoriaDeOcorrencia>> ocorrenciasFuture;
  CategoriaDeOcorrencia? selectedOcorrencia;
  bool _showOcorrenciaForm = false;
  TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ocorrenciasFuture = getOcorrencias();
    servicoFuture = getServicos(widget.servicoId);
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('usuario') ?? '';
      if (nome!.isNotEmpty) {
        nome = utf8.decode(nome!.codeUnits);
      }
      token = prefs.getString('token') ?? '';
      if (token.isEmpty) {
        throw Exception('Token é nulo ou vazio');
      }
    });
  }

  Future<Servico> getServicos(int id) async {
    try {
      await _loadPreferences();
      ServicoService servicoService = ServicoService();
      Map<String, String> params = {};
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        ...servicoService.headers,
      };
      http.Response response = await servicoService.get(
          '/${widget.servicoId}', params, requestHeaders);
      if (response.statusCode == 200) {
        Servico servico = Servico.fromJson(jsonDecode(response.body));
        return servico;
      } else {
        throw Exception(
            'Falha ao carregar os serviços. Código: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar serviços: $e');
    }
  }

  Future<List<CategoriaDeOcorrencia>> getOcorrencias() async {
    try {
      await _loadPreferences();
      CategoriaDeOcorrenciaService categoriaDeOcorrenciaService =
          CategoriaDeOcorrenciaService();
      Map<String, String> params = {};
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        ...categoriaDeOcorrenciaService.headers,
      };
      http.Response response = await categoriaDeOcorrenciaService.get(
          '/todos', params, requestHeaders);
      if (response.statusCode == 200) {
        List<dynamic> ocorrenciasJson = jsonDecode(response.body);
        List<CategoriaDeOcorrencia> ocorrencias = ocorrenciasJson
            .map((json) => CategoriaDeOcorrencia.fromJson(json))
            .toList();
        return ocorrencias;
      } else {
        throw Exception(
            'Failed to load occurrences. Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching occurrences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 248, 255, 1),
        automaticallyImplyLeading: true,
        title: Text(
          'Registro de Serviço',
          style: TextStyle(
            fontSize: 24, // adjust the size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(child: _itensRegistro()),
    );
  }

  FutureBuilder<Servico> _itensRegistro() {
    return FutureBuilder<Servico>(
      future: servicoFuture,
      builder: (BuildContext context, AsyncSnapshot<Servico> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Servico servico = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _descricaoAmbiente(servico),
                _tipoLimpeza(servico),
                _listaAtividades(servico),
                _ocorrencia(),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 60,
                    child: TextButton(
                      onPressed: () => {
                        // ! TODO: chamar endpoint de atualizar serviço
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromRGBO(12, 98, 160, 1),
                      ),
                      child: const Text(
                        'Finalizar Serviço',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("Nenhum serviço encontrado."));
        }
      },
    );
  }

  Widget _ocorrencia() {
    return _showOcorrenciaForm
        ? FutureBuilder<List<CategoriaDeOcorrencia>>(
            future: ocorrenciasFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoriaDeOcorrencia>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<CategoriaDeOcorrencia> ocorrencias = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ocorrência:',
                              style: TextStyle(
                                color: const Color.fromRGBO(1, 28, 57, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showOcorrenciaForm = false;
                                  selectedOcorrencia =
                                      null; 
                                  _descricaoController
                                      .clear();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                surfaceTintColor: Colors.transparent,
                                minimumSize: Size(40, 40),
                                padding: EdgeInsets.zero,
                                shape: CircleBorder(),
                              ),
                              child: Text(
                                'X',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButton<CategoriaDeOcorrencia>(
                              value: selectedOcorrencia,
                              hint: Text(
                                'Selecione uma ocorrência',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.normal), // Text color
                              ),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (CategoriaDeOcorrencia? newValue) {
                                setState(() {
                                  selectedOcorrencia = newValue;
                                });
                              },
                              items: [
                                DropdownMenuItem<CategoriaDeOcorrencia>(
                                  value: null,
                                  child: Text(
                                    'Selecione uma ocorrência',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                ...ocorrencias.map<
                                    DropdownMenuItem<CategoriaDeOcorrencia>>(
                                  (CategoriaDeOcorrencia ocorrencia) {
                                    return DropdownMenuItem<
                                        CategoriaDeOcorrencia>(
                                      value: ocorrencia,
                                      child: Text(
                                        ocorrencia.categoria,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .normal), // Dropdown item text color
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(12),
                          child: TextField(
                            controller: _descricaoController,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Descrição da Ocorrência',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(12, 98, 160, 1),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text("Nenhuma ocorrência encontrada."));
              }
            },
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: 200,
                height: 60,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showOcorrenciaForm = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(230, 81, 81, 1),
                  ),
                  child: const Text(
                    'Relatar ocorrência',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
  }

  Padding _listaAtividades(Servico servico) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Serviço a ser realizado:',
            style: TextStyle(
              color: const Color.fromRGBO(1, 28, 57, 1),
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            children: servico.atividades
                .map((atividade) => Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            atividade.descricao,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(9, 99, 163, 1),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Padding _tipoLimpeza(Servico servico) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: const Color.fromRGBO(1, 28, 57, 1),
            fontSize: 20,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Tipo: ',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: servico.tipoDeLimpeza.tipoDeLimpeza,
            ),
          ],
        ),
      ),
    );
  }

  Padding _descricaoAmbiente(Servico servico) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: const Color.fromRGBO(1, 28, 57, 1),
            fontSize: 20,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Ambiente: ',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: '${servico.ambiente.descricao}',
            ),
          ],
        ),
      ),
    );
  }
}
