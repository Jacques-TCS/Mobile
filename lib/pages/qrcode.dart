// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jacques/components/qrcode_overlay.dart';
import 'package:jacques/models/servico_model.dart';
import 'package:jacques/pages/registro_servico.dart';
import 'package:jacques/services/servico_service.dart';
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
    _resetScanner();
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

  Future<List<Servico>> _getServicos(String id,
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
        List<Servico> servicos =
            (jsonDecode(utf8.decode(response.bodyBytes)) as List)
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

  Future<List<Servico>> _getServicosByDataHoraInicio(
      {bool filterByDataHoraInicio = false}) async {
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
        List<Servico> servicos =
            (jsonDecode(utf8.decode(response.bodyBytes)) as List)
                .map((item) => Servico.fromJson(item))
                .toList();

        if (filterByDataHoraInicio) {
          servicos = servicos
              .where((servico) => servico.dataHoraInicio != null)
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

  Future<void> _updateServico(Servico servico) async {
    ServicoService servicoService = ServicoService();
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      'id': servico.id,
      'dataHoraInicio': DateTime.now().toIso8601String(),
    };
    http.Response response = await servicoService.put('', body, requestHeaders);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          content: AwesomeSnackbarContent(
            title: 'Serviço Iniciado!',
            message:
                'Realize as suas atividades e volte mais tarde para encerrar o serviço!',
            messageFontSize: 15,
            contentType: ContentType.success,
            color: const Color.fromARGB(255, 0, 128, 0),
            inMaterialBanner: false,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
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
                'Você não foi possível iniciar o serviço, tente novamente!',
            messageFontSize: 15,
            contentType: ContentType.warning,
            color: const Color.fromARGB(255, 0, 112, 224),
            inMaterialBanner: false,
          ),
        ),
      );
    }
  }

  void _resetScanner() {
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
                    List<Servico> servicos =
                        await _getServicos(id, filterByDataHora: true);
                    final servicosNoAmbiente = servicos
                        .where((s) => s.ambiente.id.toString() == id)
                        .toList();

                    if (servicosNoAmbiente.isNotEmpty) {
                      scannerController.stop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _dialogServicos(context, servicosNoAmbiente);
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        _alertaAvisoSemServicoAmbiente(),
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        scannerController.stop();
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

  SnackBar _alertaAvisoSemServicoAmbiente() {
    return SnackBar(
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
    );
  }

Theme _dialogServicos(
      BuildContext context, List<Servico> servicosNoAmbiente) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Color.fromRGBO(220, 242, 252, 1),
      ),
      child: AlertDialog(
        title: Text('Escolha o serviço que deseja iniciar:'),
        content: SizedBox(
          width: double.maxFinite,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: servicosNoAmbiente.length,
              itemBuilder: (BuildContext context, int index) {
                Servico servico = servicosNoAmbiente[index];
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${servico.tipoDeLimpeza.tipoDeLimpeza} - ${servico.turno.turno}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: servico.atividades
                              .map((atividade) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(
                                      atividade.descricao,
                                      style: TextStyle(
                                        fontSize: 16.0, // Change this value to your desired font size
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _escolherServicoEAtualizarHoraInicio(
                                  servicosNoAmbiente, index, context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(12, 98, 160, 1),
                            ),
                            child: Text('Iniciar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Sair');
                  Future.delayed(Duration(seconds: 1), () {
                    _resetScanner();
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(12, 98, 160, 1),
                ),
                child: const Text('Sair'),
              ),
            ),
          ),
        ],
      ),
    );
  }

void _escolherServicoEAtualizarHoraInicio(
    List<Servico> servicosNoAmbiente, int index, BuildContext context) async {
  Servico selectedServico = servicosNoAmbiente[index];
  List<Servico> servicosComInicio =
      await _getServicosByDataHoraInicio(filterByDataHoraInicio: true);
  bool hasOtherOngoingServico = servicosComInicio.any((servico) =>
      servico.dataHoraFim == null && servico.id != selectedServico.id);
  if (hasOtherOngoingServico && selectedServico.dataHoraInicio == null) {
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
              'Já existe um serviço em andamento! Finalize-o antes de iniciar um novo.',
          messageFontSize: 15,
          contentType: ContentType.warning,
          color: const Color.fromARGB(255, 255, 165, 57),
          inMaterialBanner: false,
        ),
      ),
    );
    Navigator.of(context).pop();
    await scannerController.stop();
    await scannerController.start();
    return;
  }
  if (selectedServico.dataHoraInicio != null) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistroServico(
          servicoId: selectedServico.id,
        ),
      ),
    );
    await scannerController.stop();
    return;
  }
  if (selectedServico.dataHoraInicio == null) {
    selectedServico.dataHoraInicio = DateTime.now();
    await _updateServico(selectedServico);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegistroServico(
          servicoId: selectedServico.id,
        ),
      ),
    );
    await scannerController.stop();
  }
}

}
