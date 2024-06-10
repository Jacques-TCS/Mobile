// ignore_for_file: constant_identifier_names

class CategoriaDeOcorrencia {
  final int id;
  final String categoria;

  const CategoriaDeOcorrencia._internal(this.id, this.categoria);

  static const ED = CategoriaDeOcorrencia._internal(0, "Equipamento danificado");
  static const SC = CategoriaDeOcorrencia._internal(1, "Superfície contaminada");
  static const VL = CategoriaDeOcorrencia._internal(2, "Vazamento de líquidos");
  static const RB = CategoriaDeOcorrencia._internal(3, "Resíduos biológicos");
  static const MC = CategoriaDeOcorrencia._internal(4, "Mau cheiro");
  static const IP = CategoriaDeOcorrencia._internal(5, "Insetos ou pragas");
  static const MF = CategoriaDeOcorrencia._internal(6, "Material faltante");
  static const AA = CategoriaDeOcorrencia._internal(7, "Áreas não acessíveis");
  static const DE = CategoriaDeOcorrencia._internal(8, "Danos estruturais");
  static const DP = CategoriaDeOcorrencia._internal(9, "Desconformidade com protocolos");

  static const values = [
    ED, SC, VL, RB, MC, IP, MF, AA, DE, DP
  ];

  static final Map<int, CategoriaDeOcorrencia> _byId = {
    for (var c in values) c.id: c,
  };

  static final Map<String, CategoriaDeOcorrencia> _byCategoria = {
    for (var c in values) c.categoria: c,
  };

  factory CategoriaDeOcorrencia.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory CategoriaDeOcorrencia.fromCategoria(String categoria) {
    return _byCategoria[categoria] ?? (throw ArgumentError('Invalid categoria: $categoria'));
  }

  factory CategoriaDeOcorrencia.fromJson(Map<String, dynamic> json) {
    return CategoriaDeOcorrencia.fromId(json['id']);
  }

  Map<String, dynamic> toJson(CategoriaDeOcorrencia categoriaDeOcorrencia) {
    return {
      'id': id,
      'categoria': categoria,
    };
  }

  @override
  String toString() {
    return 'CategoriaDeOcorrencia{id: $id, categoria: $categoria}';
  }
}