import 'package:mobile/models/tipo_de_limpeza_model.dart';

class Cronograma {
  final int id;
  final int mes;
  final TipoDeLimpeza tipoDeLimpeza;

  Cronograma({
    this.id = 0,
    required this.mes,
    required this.tipoDeLimpeza
  });

  factory Cronograma.fromJson(Map<String, dynamic> json) {
    return Cronograma(
      id: json['id'],
      mes: json['mes'],
      tipoDeLimpeza: TipoDeLimpeza.fromJson(json['tipoDeLimpeza'])
    );
  }

  Map<String, dynamic> toJson(Cronograma cronograma) {
    return {
      'id': id,
      'mes': mes,
      'tipoDeLimpeza': tipoDeLimpeza.toJson(tipoDeLimpeza)
    };
  }

  @override
  String toString() {
    return 'Cronograma{id: $id, mes: $mes, tipoDeLimpeza: $tipoDeLimpeza}';
  }
}