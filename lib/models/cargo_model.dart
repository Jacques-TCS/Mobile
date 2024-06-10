// ignore_for_file: constant_identifier_names

class Cargo {
  final int id;
  final String cargo;

  const Cargo._internal(this.id, this.cargo);

  static const GERENTE = Cargo._internal(0, "Gerente");
  static const COLABORADOR = Cargo._internal(1, "Colaborador");

  static const values = [
    GERENTE,
    COLABORADOR,
  ];

  static final Map<int, Cargo> _byId = {
    for (var c in values) c.id: c,
  };

  static final Map<String, Cargo> _byCargo = {
    for (var c in values) c.cargo: c,
  };

  factory Cargo.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory Cargo.fromCargo(String cargo) {
    return _byCargo[cargo] ?? (throw ArgumentError('Invalid cargo: $cargo'));
  }

  factory Cargo.fromJson(Map<String, dynamic> json) {
    return Cargo.fromId(json['id']);
  }

  Map<String, dynamic> toJson(Cargo cargo) {
    return {
      'id': id,
      'cargo': cargo,
    };
  }

  @override
  String toString() {
    return 'Cargo{id: $id, cargo: $cargo}';
  }
}
