// ignore_for_file: non_constant_identifier_names

class ServicoModel {

  final int id, id_ambiente, id_cronograma, id_usuario, tipo_de_limpeza;
  final DateTime data_hora_fim, data_hora_inicio;
  
  ServicoModel({
    required this.id,
    required this.id_ambiente,
    required this.id_cronograma,
    required this.id_usuario,
    required this.tipo_de_limpeza,
    required this.data_hora_fim,
    required this.data_hora_inicio
  });

  factory ServicoModel.fromJson(Map<String, dynamic> json) {
    return ServicoModel(
      id: json['id'],
      id_ambiente: json['id_ambiente'],
      id_cronograma: json['id_cronograma'],
      id_usuario: json['id_usuario'],
      tipo_de_limpeza: json['tipo_de_limpeza'],
      data_hora_fim: DateTime.parse(json['data_hora_fim']),
      data_hora_inicio: DateTime.parse(json['data_hora_inicio'])
    );
  }

  Map<String, dynamic> toJson(ServicoModel servico) {
    return {
      'id': id,
      'id_ambiente': id_ambiente,
      'id_cronograma': id_cronograma,
      'id_usuario': id_usuario,
      'tipo_de_limpeza': tipo_de_limpeza,
      'data_hora_fim': data_hora_fim,
      'data_hora_inicio': data_hora_inicio
    };
  }

  @override
  String toString() {
    return 'ServicoModel{id: $id, id_ambiente: $id_ambiente, id_cronograma: $id_cronograma, id_usuario: $id_usuario, tipo_de_limpeza: $tipo_de_limpeza, data_hora_fim: $data_hora_fim, data_hora_inicio: $data_hora_inicio}';
  }
}