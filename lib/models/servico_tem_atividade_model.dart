import 'atividade_model.dart';
import 'servico_model.dart';

class ServicoTemAtividade {
  final int id;
  Servico? servico;
  Atividade? atividade;

  ServicoTemAtividade({
    this.id = 0,
    this.servico,
    this.atividade
  });

  factory ServicoTemAtividade.fromJson(Map<String, dynamic> json) {
    return ServicoTemAtividade(
      id: json['id'],
      servico: Servico.fromJson(json['servico']),
      atividade: Atividade.fromJson(json['atividade'])
    );
  }

  Map<String, dynamic> toJson(ServicoTemAtividade servicoTemAtividade) {
    return {
      'id': id,
      'servico': servico?.toJson(servico!),
      'atividade': atividade?.toJson(atividade!)
    };
  }

  @override
  String toString() {
    return 'ServicoTemAtividade{id: $id, servico: $servico, atividade: $atividade}';
  }
}