// ignore_for_file: constant_identifier_names

class TipoDeLimpeza {
  final int id;
  final String tipoDeLimpeza;

  const TipoDeLimpeza._internal(this.id, this.tipoDeLimpeza);

  static const LIMPEZA_TERMINAL = TipoDeLimpeza._internal(0, "Limpeza Terminal");
  static const LIMPEZA_CONCORRENTE = TipoDeLimpeza._internal(1, "Limpeza Concorrente");
  static const LIMPEZA_TERMINAL_PROGRAMADA = TipoDeLimpeza._internal(2, "Limpeza Terminal Programada");

  static const values = [
    LIMPEZA_TERMINAL,
    LIMPEZA_CONCORRENTE,
    LIMPEZA_TERMINAL_PROGRAMADA,
  ];

  static final Map<int, TipoDeLimpeza> _byId = {
    for (var t in values) t.id: t,
  };

  static final Map<String, TipoDeLimpeza> _byTipoDeLimpeza = {
    for (var t in values) t.tipoDeLimpeza: t,
  };

  factory TipoDeLimpeza.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory TipoDeLimpeza.fromTipoDeLimpeza(String tipoDeLimpeza) {
    return _byTipoDeLimpeza[tipoDeLimpeza] ?? (throw ArgumentError('Invalid tipoDeLimpeza: $tipoDeLimpeza'));
  }

  factory TipoDeLimpeza.fromJson(Map<String, dynamic> json) {
    return TipoDeLimpeza.fromId(json['id']);
  }

  Map<String, dynamic> toJson(TipoDeLimpeza tipoDeLimpeza) {
    return {
      'id': id,
      'tipoDeLimpeza': tipoDeLimpeza,
    };
  }

  @override
  String toString() {
    return 'TipoDeLimpeza{id: $id, tipoDeLimpeza: $tipoDeLimpeza}';
  }
}
