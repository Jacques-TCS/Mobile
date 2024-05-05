// ! TODO: enum
class TipoDeAmbiente {
  final int id;
  final String tipoDeAmbiente;

  TipoDeAmbiente({
    this.id = 0,
    required this.tipoDeAmbiente
  });

  factory TipoDeAmbiente.fromJson(Map<String, dynamic> json) {
    return TipoDeAmbiente(
      id: json['id'],
      tipoDeAmbiente: json['tipoDeAmbiente']
    );
  }

  Map<String, dynamic> toJson(TipoDeAmbiente tipoDeAmbiente) {
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