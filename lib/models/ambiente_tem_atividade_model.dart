// ignore_for_file: non_constant_identifier_names

import 'package:mobile/models/frequencia_de_limpeza_model.dart';

import 'ambiente_model.dart';
import 'atividade_model.dart';

class AmbienteTemAtividade {
  final int id;
  final Ambiente ambiente;
  final Atividade atividade;
  final FrequenciaDeLimpeza frequencia_limpeza_concorrente_turno_matutino, frequencia_limpeza_concorrente_turno_vespertino, frequencia_limpeza_concorrente_turno_noturno, frequencia_limpeza_terminal_turno_matutino, frequencia_limpeza_terminal_turno_vespertino, frequencia_limpeza_terminal_turno_noturno;

  AmbienteTemAtividade({
    this.id = 0,
    required this.ambiente,
    required this.atividade,
    required this.frequencia_limpeza_concorrente_turno_matutino,
    required this.frequencia_limpeza_concorrente_turno_vespertino,
    required this.frequencia_limpeza_concorrente_turno_noturno,
    required this.frequencia_limpeza_terminal_turno_matutino,
    required this.frequencia_limpeza_terminal_turno_vespertino,
    required this.frequencia_limpeza_terminal_turno_noturno
  });

  factory AmbienteTemAtividade.fromJson(Map<String, dynamic> json) {
    return AmbienteTemAtividade(
      id: json['id'],
      ambiente: Ambiente.fromJson(json['ambiente']),
      atividade: Atividade.fromJson(json['atividade']),
      frequencia_limpeza_concorrente_turno_matutino: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_concorrente_turno_matutino']),
      frequencia_limpeza_concorrente_turno_vespertino: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_concorrente_turno_vespertino']),
      frequencia_limpeza_concorrente_turno_noturno: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_concorrente_turno_noturno']),
      frequencia_limpeza_terminal_turno_matutino: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_terminal_turno_matutino']),
      frequencia_limpeza_terminal_turno_vespertino: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_terminal_turno_vespertino']),
      frequencia_limpeza_terminal_turno_noturno: FrequenciaDeLimpeza.fromJson(json['frequencia_limpeza_terminal_turno_noturno'])
    );
  }

  Map<String, dynamic> toJson(AmbienteTemAtividade ambiente_tem_atividade) {
    return {
      'id': id,
      'ambiente': ambiente.toJson(ambiente),
      'atividade': atividade.toJson(atividade),
      'frequencia_limpeza_concorrente_turno_matutino': frequencia_limpeza_concorrente_turno_matutino.toJson(frequencia_limpeza_concorrente_turno_matutino),
      'frequencia_limpeza_concorrente_turno_vespertino': frequencia_limpeza_concorrente_turno_vespertino.toJson(frequencia_limpeza_concorrente_turno_vespertino),
      'frequencia_limpeza_concorrente_turno_noturno': frequencia_limpeza_concorrente_turno_noturno.toJson(frequencia_limpeza_concorrente_turno_noturno),
      'frequencia_limpeza_terminal_turno_matutino': frequencia_limpeza_terminal_turno_matutino.toJson(frequencia_limpeza_terminal_turno_matutino),
      'frequencia_limpeza_terminal_turno_vespertino': frequencia_limpeza_terminal_turno_vespertino.toJson(frequencia_limpeza_terminal_turno_vespertino),
      'frequencia_limpeza_terminal_turno_noturno': frequencia_limpeza_terminal_turno_noturno.toJson(frequencia_limpeza_terminal_turno_noturno)
    };
  }

  @override
  String toString() {
    return 'AmbienteTemAtividade{id: $id, ambiente: $ambiente, atividade: $atividade, frequencia_limpeza_concorrente_turno_matutino: $frequencia_limpeza_concorrente_turno_matutino, frequencia_limpeza_concorrente_turno_vespertino: $frequencia_limpeza_concorrente_turno_vespertino, frequencia_limpeza_concorrente_turno_noturno: $frequencia_limpeza_concorrente_turno_noturno, frequencia_limpeza_terminal_turno_matutino: $frequencia_limpeza_terminal_turno_matutino, frequencia_limpeza_terminal_turno_vespertino: $frequencia_limpeza_terminal_turno_vespertino, frequencia_limpeza_terminal_turno_noturno: $frequencia_limpeza_terminal_turno_noturno}';
  }
}