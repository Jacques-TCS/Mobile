import 'tipo_de_ambiente_model.dart';

class Setor {
  final int id;
  final String nome;
  final String sigla;
  final bool internacao;
  final TipoDeAmbiente tipoDeAmbiente;

  Setor({
    this.id = 0,
    required this.nome,
    required this.sigla,
    required this.internacao,
    required this.tipoDeAmbiente,
  });

  factory Setor.fromJson(Map<String, dynamic> json) {
    return Setor(
      id: json['id'],
      nome: json['nome'],
      sigla: json['sigla'],
      internacao: json['internacao'],
      tipoDeAmbiente: TipoDeAmbiente.fromJson(json['tipoDeAmbiente']),
    );
  }

  Map<String, dynamic> toJson(Setor setor) {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
      'internacao': internacao,
      'tipoDeAmbiente': tipoDeAmbiente.toJson(),
    };
  }

  @override
  String toString() {
    return 'Setor{id: $id, nome: $nome, sigla: $sigla, internacao: $internacao, tipoDeAmbiente: $tipoDeAmbiente}';
  }
}
