// ignore_for_file: constant_identifier_names

class TipoDeAmbiente {
  final int id;
  final String tipoDeAmbiente;

  const TipoDeAmbiente._internal(this.id, this.tipoDeAmbiente);

  static const AREA_CRITICA = TipoDeAmbiente._internal(0, "Área crítica");
  static const AREA_SEMICRITICA = TipoDeAmbiente._internal(1, "Área semicrítica");
  static const AREA_NAO_CRITICA = TipoDeAmbiente._internal(2, "Área não crítica");
  static const AREA_EXTERNA = TipoDeAmbiente._internal(3, "Área externa");

  static const values = [
    AREA_CRITICA,
    AREA_SEMICRITICA,
    AREA_NAO_CRITICA,
    AREA_EXTERNA
  ];

  static final Map<int, TipoDeAmbiente> _byId = {
    for (var t in values) t.id: t
  };

  static final Map<String, TipoDeAmbiente> _byTipoDeAmbiente = {
    for (var t in values) t.tipoDeAmbiente: t
  };

  factory TipoDeAmbiente.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory TipoDeAmbiente.fromTipoDeAmbiente(String tipoDeAmbiente) {
    return _byTipoDeAmbiente[tipoDeAmbiente] ?? (throw ArgumentError('Invalid tipoDeAmbiente: $tipoDeAmbiente'));
  }

  factory TipoDeAmbiente.fromJson(Map<String, dynamic> json) {
    return TipoDeAmbiente.fromId(json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoDeAmbiente': tipoDeAmbiente
    };
  }

  @override
  String toString() {
    return 'TipoDeAmbiente{id: $id, tipoDeAmbiente: $tipoDeAmbiente}';
  }
}
