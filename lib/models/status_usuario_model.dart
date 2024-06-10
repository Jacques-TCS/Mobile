// ignore_for_file: constant_identifier_names

class StatusUsuario {
  final int id;
  final String status;

  const StatusUsuario._internal(this.id, this.status);

  static const INATIVO = StatusUsuario._internal(0, "Inativo");
  static const ATIVO = StatusUsuario._internal(1, "Ativo");
  static const AFASTADO = StatusUsuario._internal(2, "Afastado");

  static const values = [
    INATIVO,
    ATIVO,
    AFASTADO,
  ];

  static final Map<int, StatusUsuario> _byId = {
    for (var c in values) c.id: c,
  };

  static final Map<String, StatusUsuario> _byStatus = {
    for (var c in values) c.status: c,
  };

  factory StatusUsuario.fromId(int id) {
    return _byId[id] ?? (throw ArgumentError('Invalid id: $id'));
  }

  factory StatusUsuario.fromStatus(String status) {
    return _byStatus[status] ?? (throw ArgumentError('Invalid status: $status'));
  }

  factory StatusUsuario.fromJson(Map<String, dynamic> json) {
    return StatusUsuario.fromId(json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'StatusUsuario{id: $id, status: $status}';
  }
}
