// ! TODO: enum
class CategoriaDeOcorrencia {
  final int id;
  final String categoria;

  CategoriaDeOcorrencia({
    this.id = 0,
    required this.categoria
  });

  factory CategoriaDeOcorrencia.fromJson(Map<String, dynamic> json) {
    return CategoriaDeOcorrencia(
      id: json['id'],
      categoria: json['categoria']
    );
  }

  Map<String, dynamic> toJson(CategoriaDeOcorrencia categoriaDeOcorrencia) {
    return {
      'id': id,
      'categoria': categoria
    };
  }

  @override
  String toString() {
    return 'CategoriaDeOcorrencia{id: $id, categoria: $categoria}';
  }
}