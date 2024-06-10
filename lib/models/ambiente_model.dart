import 'setor_model.dart';
// import 'tipo_de_ambiente_model.dart';

class Ambiente {
  final int id;
  String? descricao;
  Setor? setor;
  // TipoDeAmbiente? tipoDeAmbiente;

  Ambiente({
    this.id = 0,
    this.descricao,
    this.setor,
  });

  factory Ambiente.fromJson(Map<String, dynamic> json) {
    return Ambiente(
      id: json['id'],
      descricao: json['descricao'],
      setor: json['setor'] != null ? Setor.fromJson(json['setor']) : null,
      // tipoDeAmbiente: json['tipoDeAmbiente'] != null ? TipoDeAmbiente.fromJson(json['tipoDeAmbiente']) : null,
    );
  }

  Map<String, dynamic> toJson(Ambiente ambiente) {
    return {
      'id': id,
      'descricao': descricao,
      'setor': setor?.toJson(setor!),
      // 'tipoDeAmbiente': tipoDeAmbiente?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Ambiente{id: $id, descricao: $descricao, setor: $setor}';
    // , tipoDeAmbiente: $tipoDeAmbiente
  }
}
