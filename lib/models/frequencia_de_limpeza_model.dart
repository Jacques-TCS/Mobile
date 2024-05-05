// ! TODO: enum
class FrequenciaDeLimpeza {
  final int id;
  final String frequencia;

  FrequenciaDeLimpeza({
    this.id = 0,
    required this.frequencia
  });

  factory FrequenciaDeLimpeza.fromJson(Map<String, dynamic> json) {
    return FrequenciaDeLimpeza(
      id: json['id'],
      frequencia: json['frequencia']
    );
  }

  Map<String, dynamic> toJson(FrequenciaDeLimpeza frequenciaDeLimpeza) {
    return {
      'id': id,
      'frequencia': frequencia
    };
  }

  @override
  String toString() {
    return 'FrequenciaDeLimpeza{id: $id, frequencia: $frequencia}';
  }
}