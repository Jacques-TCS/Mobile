import 'atividade_model.dart';
import 'servico_model.dart';

class SetorTemAtividade {
  final int id;
  final Servico servico;
  final Atividade atividade;

  SetorTemAtividade({
    this.id = 0,
    required this.servico,
    required this.atividade
  });

  factory SetorTemAtividade.fromJson(Map<String, dynamic> json) {
    return SetorTemAtividade(
      id: json['id'],
      servico: Servico.fromJson(json['servico']),
      atividade: Atividade.fromJson(json['atividade'])
    );
  }

  Map<String, dynamic> toJson(SetorTemAtividade SetorTemAtividade) {
    return {
      'id': id,
      'servico': servico.toJson(servico),
      'atividade': atividade.toJson(atividade)
    };
  }

  @override
  String toString() {
    return 'SetorTemAtividade{id: $id, servico: $servico, atividade: $atividade}';
  }
}