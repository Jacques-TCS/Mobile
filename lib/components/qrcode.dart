// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
  late MobileScannerController scannerController;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    _loadPreferences();
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

  Map<String, String> get headers {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Servico>> getServicos(String id,
      {bool filterByDataHora = false}) async {
    try {
      await _loadPreferences();
      ServicoService servicoService = ServicoService();
      Map<String, String> params = {};
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        ...servicoService.headers,
      };
      http.Response response = await servicoService.get(
          '/servicos-dia-ambiente/$id', params, requestHeaders);
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

  void _resetScanner() {
    scannerController.stop();
    scannerController.start();
  }

  @override
  void dispose() {
    scannerController.stop();
    super.dispose();
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
              controller: scannerController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final id = barcode.rawValue?.split(':').last.trim();
                  if (id != null) {
                    try {
                      List<Servico> servicos =
                          await getServicos(id, filterByDataHora: true);
                      final servicosNoAmbiente = servicos
                          .where((s) => s.ambiente.id.toString() == id)
                          .toList();
                      ('Servicos in ambiente: $servicosNoAmbiente');

                      if (servicosNoAmbiente.isNotEmpty) {
                        ('Showing dialog...');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                dialogBackgroundColor:
                                    Color.fromRGBO(220, 242, 252, 1),
                              ),
                              child: AlertDialog(
                                title: Text(
                                    'Escolha o serviço que deseja iniciar:'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: servicosNoAmbiente.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      ('Building list item $index');
                                      return ListTile(
                                        title: Container(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 400,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistroServico(
                                                      servicoId:
                                                          servicosNoAmbiente[
                                                                  index]
                                                              .id,
                                                    ),
                                                  ),
                                                );
                                                await scannerController.stop(); 
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Color.fromRGBO(
                                                    12,
                                                    98,
                                                    160,
                                                    1), // button color
                                              ),
                                              child: Text(
                                                  "#${servicosNoAmbiente[index].id}: ${servicosNoAmbiente[index].tipoDeLimpeza.tipoDeLimpeza}"),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Sair');
                                        _resetScanner();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color.fromRGBO(
                                            12, 98, 160, 1), // button color
                                      ),
                                      child: const Text('Sair'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            duration: Duration(seconds: 2),
                            content: AwesomeSnackbarContent(
                              title: 'Atenção!',
                              message:
                                  'Você não possui serviço neste ambiente!',
                              messageFontSize: 15,
                              contentType: ContentType.warning,
                              color: const Color.fromARGB(255, 255, 165, 57),
                              inMaterialBanner: false,
                            ),
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          _resetScanner();
                        });
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          duration: Duration(seconds: 2),
                          content: AwesomeSnackbarContent(
                            title: 'Atenção!',
                            message: 'Você não possui serviço neste ambiente!',
                            messageFontSize: 15,
                            contentType: ContentType.warning,
                            color: const Color.fromARGB(255, 255, 165, 57),
                            inMaterialBanner: false,
                          ),
                        ),
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        _resetScanner();
                      });
                    }
                  }
                }
              },
            ),
            QRcodeOverlay(overlayColour: Colors.black.withOpacity(0.3))
          ])),
    );
  }
}
