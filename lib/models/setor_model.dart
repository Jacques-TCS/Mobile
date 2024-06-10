
class Setor {
  final int id;
  final String nome;
  final String sigla;

  Setor({
    this.id = 0,
    required this.nome,
    required this.sigla,
  });

  factory Setor.fromJson(Map<String, dynamic> json) {
    return Setor(
      id: json['id'],
      nome: json['nome'],
      sigla: json['sigla'],
    );
  }

  Map<String, dynamic> toJson(Setor setor) {
    return {
      'id': id,
      'nome': nome,
      'sigla': sigla,
    };
  }

  @override
  String toString() {
    return 'Setor{id: $id, nome: $nome, sigla: $sigla}';
  }
}
