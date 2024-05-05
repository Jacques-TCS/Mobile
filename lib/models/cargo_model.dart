// ! TODO: enum
class Cargo {
  final int id;
  final String cargo;

  Cargo({
    this.id = 0,
    required this.cargo
  });

  factory Cargo.fromJson(Map<String, dynamic> json) {
    return Cargo(
      id: json['id'],
      cargo: json['cargo']
    );
  }

  Map<String, dynamic> toJson(Cargo cargo) {
    return {
      'id': id,
      'cargo': cargo
    };
  }

  @override
  String toString() {
    return 'Cargo{id: $id, cargo: $cargo}';
  }
}