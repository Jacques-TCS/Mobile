// ignore_for_file: constant_identifier_names

class FrequenciaDeLimpeza {
  final int id;
  final String frequencia;

  const FrequenciaDeLimpeza._internal(this.id, this.frequencia);

  static const UMA_VEZ_AO_DIA = FrequenciaDeLimpeza._internal(0, "1x ao dia");
  static const DUAS_VEZES_AO_DIA = FrequenciaDeLimpeza._internal(1, "2x ao dia");
  static const TRES_VEZES_AO_DIA = FrequenciaDeLimpeza._internal(2, "3x ao dia");
  static const SEMANALMENTE = FrequenciaDeLimpeza._internal(3, "Semanalmente");
  static const QUINZENALMENTE = FrequenciaDeLimpeza._internal(4, "Quinzenalmente");
  static const NAO_SE_APLICA = FrequenciaDeLimpeza._internal(5, "Não se aplica");

  static const values = [
    UMA_VEZ_AO_DIA,
    DUAS_VEZES_AO_DIA,
    TRES_VEZES_AO_DIA,
    SEMANALMENTE,
    QUINZENALMENTE,
    NAO_SE_APLICA,
  ];

  static final Map<int, FrequenciaDeLimpeza> _byId = {
    for (var f in values) f.id: f,
  };

  static final Map<String, FrequenciaDeLimpeza> _byFrequencia = {
    for (var f in values) f.frequencia: f,
  };

  factory FrequenciaDeLimpeza.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory FrequenciaDeLimpeza.fromFrequencia(String frequencia) {
    return _byFrequencia[frequencia] ?? (throw ArgumentError('Invalid frequencia: $frequencia'));
  }

  factory FrequenciaDeLimpeza.fromJson(Map<String, dynamic> json) {
    return FrequenciaDeLimpeza.fromId(json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'frequencia': frequencia,
    };
  }

  @override
  String toString() {
    return 'FrequenciaDeLimpeza{id: $id, frequencia: $frequencia}';
  }
}
