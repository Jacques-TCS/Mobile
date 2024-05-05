
import 'package:mobile/pages/servico.dart';
import 'categoria_de_ocorrencia_model.dart';

class Ocorrencia {
  final int id;
  final String descricao;
  final bool status;
  final DateTime dataOcorrencia;
  final Servico servico;
  final CategoriaDeOcorrencia categoriaDeOcorrencia;

  Ocorrencia({
    this.id = 0,
    required this.descricao,
    required this.status,
    required this.dataOcorrencia,
    required this.servico,
    required this.categoriaDeOcorrencia
  });

  factory Ocorrencia.fromJson(Map<String, dynamic> json) {
    return Ocorrencia(
      id: json['id'],
      descricao: json['descricao'],
      status: json['status'],
      dataOcorrencia: DateTime.parse(json['dataOcorrencia']),
      servico: Servico.fromJson(json['servico']),
      categoriaDeOcorrencia: CategoriaDeOcorrencia.fromJson(json['categoriaDeOcorrencia'])
    );
  }

  Map<String, dynamic> toJson(Ocorrencia ocorrencia) {
    return {
      'id': id,
      'descricao': descricao,
      'status': status,
      'dataOcorrencia': dataOcorrencia.toString(),
      'servico': servico.toJson(servico),
      'categoriaDeOcorrencia': categoriaDeOcorrencia.toJson(categoriaDeOcorrencia)
    };
  }

  @override
  String toString() {
    return 'Ocorrencia{id: $id, descricao: $descricao, status: $status, dataOcorrencia: $dataOcorrencia, servico: $servico, categoriaDeOcorrencia: $categoriaDeOcorrencia}';
  }
}