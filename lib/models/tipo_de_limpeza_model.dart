// ! TODO: enum
class TipoDeLimpeza {
  final int id;
  final String tipoDeLimpeza;

  TipoDeLimpeza({
    this.id = 0,
    required this.tipoDeLimpeza
  });

  factory TipoDeLimpeza.fromJson(Map<String, dynamic> json) {
    return TipoDeLimpeza(
      id: json['id'],
      tipoDeLimpeza: json['tipoDeLimpeza']
    );
  }

  Map<String, dynamic> toJson(TipoDeLimpeza tipoDeLimpeza) {
    return {
      'id': id,
      'tipoDeLimpeza': tipoDeLimpeza
    };
  }

  @override
  String toString() {
    return 'TipoDeLimpeza{id: $id, tipoDeLimpeza: $tipoDeLimpeza}';
  }
}