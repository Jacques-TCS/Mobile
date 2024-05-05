// ignore_for_file: non_constant_identifier_names

import 'ambiente_model.dart';
import 'cronograma_model.dart';
import 'ocorrencia_model.dart';
import 'tipo_de_limpeza_model.dart';
import 'usuario_model.dart';
import 'servico_tem_atividade_model.dart';

class Servico {

  final int id;
  final DateTime dataHoraFim, dataHoraInicio, dataProgramada;
  final Ambiente ambiente;
  final Usuario usuario;
  final Cronograma cronograma;
  final TipoDeLimpeza tipoDeLimpeza;
  final List<ServicoTemAtividade> atividades;
  final List<Ocorrencia> ocorrencias;
  
  Servico({
    this.id = 0,
    required this.dataHoraFim,
    required this.dataHoraInicio,
    required this.dataProgramada,
    required this.ambiente,
    required this.usuario,
    required this.cronograma,
    required this.tipoDeLimpeza,
    required this.atividades,
    required this.ocorrencias
  });

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      id: json['id'],
      dataHoraFim: DateTime.parse(json['dataHoraFim']),
      dataHoraInicio: DateTime.parse(json['dataHoraInicio']),
      dataProgramada: DateTime.parse(json['dataProgramada']),
      ambiente: Ambiente.fromJson(json['ambiente']),
      usuario: Usuario.fromJson(json['usuario']),
      cronograma: Cronograma.fromJson(json['cronograma']),
      tipoDeLimpeza: TipoDeLimpeza.fromJson(json['tipoDeLimpeza']),
      atividades: (json['atividades'] as List).map((atividade) => ServicoTemAtividade.fromJson(atividade)).toList(),
      ocorrencias: (json['ocorrencias'] as List).map((ocorrencia) => Ocorrencia.fromJson(ocorrencia)).toList()
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
      'ocorrencias': ocorrencias.map((ocorrencia) => ocorrencia.toJson(ocorrencia)).toList()
    };
  }

  @override
  String toString() {
    return 'Servico{id: $id, dataHoraFim: $dataHoraFim, dataHoraInicio: $dataHoraInicio, dataProgramada: $dataProgramada, ambiente: $ambiente, usuario: $usuario, cronograma: $cronograma, tipoDeLimpeza: $tipoDeLimpeza, atividades: $atividades, ocorrencias: $ocorrencias}';
  }
}