import 'setor_tem_atividade_model.dart';
import 'tipo_de_ambiente_model.dart';

class Setor {
  final int id;
  final String nome, sigla;
  final bool internacao;
  final TipoDeAmbiente tipoDeAmbiente;
  final List<SetorTemAtividade> atividades;

  Setor({
    this.id = 0,
    required this.nome,
    required this.sigla,
    required this.internacao,
    required this.tipoDeAmbiente,
    required this.atividades
  });

  factory Setor.fromJson(Map<String, dynamic> json) {
    return Setor(
      id: json['id'],
      nome: json['nome'],
      sigla: json['sigla'],
      internacao: json['internacao'],
      tipoDeAmbiente: TipoDeAmbiente.fromJson(json['tipoDeAmbiente']),
      atividades: (json['atividades'] as List).map((atividade) => SetorTemAtividade.fromJson(atividade)).toList()
    );
  }

  Map<String, dynamic> toJson(Setor setor) {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'internacao': internacao,
      'tipoDeAmbiente': tipoDeAmbiente.toJson(tipoDeAmbiente),
      'atividades': atividades.map((atividade) => atividade.toJson(atividade)).toList()
    };
  }

  @override
  String toString() {
    return 'Setor{id: $id, nome: $nome, sigla: $sigla, internacao: $internacao, tipoDeAmbiente: $tipoDeAmbiente, atividades: $atividades}';
  }
}