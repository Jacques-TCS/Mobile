// ! TODO: enum
class StatusUsuario {
  final int id;
  final String status;

  StatusUsuario({
    this.id = 0,
    required this.status
  });

  factory StatusUsuario.fromJson(Map<String, dynamic> json) {
    return StatusUsuario(
      id: json['id'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson(StatusUsuario statusUsuario) {
    return {
      'id': id,
      'status': status
    };
  }

  @override
  String toString() {
    return 'StatusUsuario{id: $id, status: $status}';
  }
}