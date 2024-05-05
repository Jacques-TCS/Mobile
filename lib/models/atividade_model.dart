class Atividade {
  final int id;
  final String descricao;

  Atividade({
    this.id = 0,
    required this.descricao
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      id: json['id'],
      descricao: json['descricao']
    );
  }

  Map<String, dynamic> toJson(Atividade atividade) {
    return {
      'id': id,
      'descricao': descricao
    };
  }

  @override
  String toString() {
    return 'Atividade{id: $id, descricao: $descricao}';
  }
}