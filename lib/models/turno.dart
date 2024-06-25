
class Turno {
  final int id;
  final String turno;

  Turno({
    this.id = 0,
    required this.turno,
  });

  factory Turno.fromJson(Map<String, dynamic> json) {
    return Turno(
      id: json['id'],
      turno: json['turno'],
    );
  }

  Map<String, dynamic> toJson(Turno turno) {
    return {
      'id': id,
      'turno': turno,
    };
  }

  @override
  String toString() {
    return 'Turno{id: $id, turno: $turno}';
  }
}
