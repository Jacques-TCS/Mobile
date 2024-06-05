// ignore_for_file: non_constant_identifier_names

import 'package:mobile/models/atividade_model.dart';

import 'ambiente_model.dart';
import 'cronograma_model.dart';
import 'tipo_de_limpeza_model.dart';
import 'usuario_model.dart';

class Servico {

  final int id;
  DateTime? dataProgramada, dataHoraFim, dataHoraInicio;
  Ambiente ambiente;
  Usuario usuario;
  Cronograma cronograma;
  TipoDeLimpeza tipoDeLimpeza;
  List<Atividade> atividades;
  
  Servico({
    this.id = 0,
    this.dataHoraFim,
    this.dataHoraInicio,
    this.dataProgramada,
    required this.ambiente,
    required this.usuario,
    required this.cronograma,
    required this.tipoDeLimpeza,
    required this.atividades,
  });

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      id: json['id'],
      dataHoraFim: json['dataHoraFim'] != null
          ? DateTime.parse(json['dataHoraFim'])
          : null, 
      dataHoraInicio: json['dataHoraInicio'] != null
          ? DateTime.parse(json['dataHoraInicio'])
          : null, 
      dataProgramada: json['dataProgramada'] != null
          ? DateTime.parse(json['dataProgramada'])
          : null, 
      ambiente: Ambiente.fromJson(json['ambiente']),
      usuario: Usuario.fromJson(json['usuario']),
      cronograma: Cronograma.fromJson(json['cronograma']),
      tipoDeLimpeza: TipoDeLimpeza.fromJson(json['tipoDeLimpeza']),
      atividades: (json['atividades'] as List)
          .map((atividade) => Atividade.fromJson(atividade))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Servico servico) {
    return {
      'id': id,
      'dataHoraFim': dataHoraFim.toString(),
      'dataHoraInicio': dataHoraInicio.toString(),
      'dataProgramada': dataProgramada.toString(),
      'ambiente': ambiente.toJson(ambiente),
      'usuario': usuario.toJson(usuario),
      'cronograma': cronograma.toJson(cronograma),
      'tipoDeLimpeza': tipoDeLimpeza.toJson(tipoDeLimpeza),
      'atividades': atividades.map((atividade) => atividade.toJson(atividade)).toList(),
    };
  }

  @override
  String toString() {
    return 'Servico{id: $id, dataHoraFim: $dataHoraFim, dataHoraInicio: $dataHoraInicio, dataProgramada: $dataProgramada, ambiente: $ambiente, usuario: $usuario, cronograma: $cronograma, tipoDeLimpeza: $tipoDeLimpeza, atividades: $atividades}';
  }
}