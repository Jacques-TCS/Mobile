// ignore_for_file: non_constant_identifier_names

import 'package:mobile/models/atividade_model.dart';
import 'package:mobile/models/turno.dart';

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
  Turno turno;
  // List<Ocorrencia>? ocorrencias;

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
    required this.turno,
    // this.ocorrencias,
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
      turno: Turno.fromJson(json['turno']),
      // ocorrencias: json['ocorrencia'] != null
      //     ? (json['ocorrencia'] as List).map((ocorrencia) => Ocorrencia.fromJson(ocorrencia)).toList()
      //     : null,
    );
  }

  Map<String, dynamic> toJson(Servico servico) {
    return {
      'id': id,
      'dataHoraFim': dataHoraFim?.toIso8601String(),
      'dataHoraInicio': dataHoraInicio?.toIso8601String(),
      'dataProgramada': dataProgramada?.toIso8601String(),
      'ambiente': ambiente.toJson(ambiente),
      'usuario': usuario.toJson(usuario),
      'cronograma': cronograma.toJson(cronograma),
      'tipoDeLimpeza': tipoDeLimpeza.toJson(),
      'atividades':
          atividades.map((atividade) => atividade.toJson(atividade)).toList(),
      'turno': turno.toJson(turno),
      // 'ocorrencia': ocorrencias?.map((ocorrencia) => ocorrencia.toJson(ocorrencia)).toList()
    };
  }

//  ocorrencias: $ocorrencias
  @override
  String toString() {
    return 'Servico{id: $id, dataHoraFim: $dataHoraFim, dataHoraInicio: $dataHoraInicio, dataProgramada: $dataProgramada, ambiente: $ambiente, usuario: $usuario, cronograma: $cronograma, tipoDeLimpeza: $tipoDeLimpeza, atividades: $atividades, turno: $turno}';
  }
}
