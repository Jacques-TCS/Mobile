import 'ambiente_tem_atividade_model.dart';
import 'setor_model.dart';
import 'tipo_de_ambiente_model.dart';

class Ambiente {
  final int id;
  final String descricao;
  final Setor setor;
  final TipoDeAmbiente tipoDeAmbiente;
  List <AmbienteTemAtividade> atividades;

  Ambiente({
    this.id = 0,
    required this.descricao,
    required this.setor,
    required this.tipoDeAmbiente,
    required this.atividades
  });

  factory Ambiente.fromJson(Map<String, dynamic> json) {
    return Ambiente(
      id: json['id'],
      descricao: json['descricao'],
      setor: Setor.fromJson(json['setor']),
      tipoDeAmbiente: TipoDeAmbiente.fromJson(json['tipoDeAmbiente']),
      atividades: (json['atividades'] as List).map((atividade) => AmbienteTemAtividade.fromJson(atividade)).toList()
    );
  }

  Map<String, dynamic> toJson(Ambiente ambiente) {
    return {
      'id': id,
      'descricao': descricao,
      'setor': setor.toJson(setor),
      'tipoDeAmbiente': tipoDeAmbiente.toJson(tipoDeAmbiente),
      'atividades': atividades.map((atividade) => atividade.toJson(atividade)).toList()
    };
  }

  @override
  String toString() {
    return 'Ambiente{id: $id, descricao: $descricao, setor: $setor, tipoDeAmbiente: $tipoDeAmbiente, atividades: $atividades}';
  }
}