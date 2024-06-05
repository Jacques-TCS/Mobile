// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/qrcode_overlay.dart';
import 'package:mobile/models/servico_model.dart';
import 'package:mobile/pages/registro_servico.dart';
import 'package:mobile/services/servico_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCode extends StatefulWidget {
  final PageController paginaController;

  const QRCode({super.key, required this.paginaController});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  String? nome;
  late String token;
  Future<List<Servico>>? _allServicos;

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
      print('Token loaded: $token');
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
      print('Headers: $requestHeaders');

      http.Response response =
          await servicoService.get('/servicos-dia', params, requestHeaders);
      if (response.statusCode == 200) {
        List<Servico> servicos = (jsonDecode(response.body) as List)
            .map((item) => Servico.fromJson(item))
            .toList();

        if (filterByDataHora) {
          servicos = servicos
              .where((servico) =>
                  servico.dataHoraInicio == null && servico.dataHoraFim == null)
              .toList();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color.fromRGBO(1, 28, 57, 1),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              onPressed: () {
                widget.paginaController.jumpToPage(0);
              },
            ),
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            elevation: 0,
          ),
          body: Stack(children: [
            MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
              ),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  _allServicos?.then((servico) {
                    final servicosInAmbiente = servico
                        .where(
                            (s) => s.ambiente.id.toString() == barcode.rawValue)
                        .toList();
                    if (servicosInAmbiente.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Choose a servico'),
                            content: ListView.builder(
                              itemCount: servicosInAmbiente.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                      servicosInAmbiente[index].toString()),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegistroServico(
                                          servicoId:
                                              servicosInAmbiente[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alerta'),
                            content:
                                Text('Você não possui serviço neste ambiente!'),
                            actions: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color.fromRGBO(
                                        12, 98, 160, 1), // button color
                                  ),
                                  child: const Text('Cancelar'),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                }
              },
            ),
            QRcodeOverlay(overlayColour: Colors.black.withOpacity(0.3))
          ])),
    );
  }
}
