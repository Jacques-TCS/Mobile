// ignore_for_file: avoid_init_to_null

import 'package:mobile/models/cargo_model.dart';

class Usuario {
  
  final int id;
  String? nome, email, username, password;
  Cargo? cargo;

  Usuario({
    this.id = 0,
    this.nome,
    this.email,
    this.username,
    this.password,
    this.cargo
  });
  
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      cargo: Cargo.fromJson(json['cargo'])
    );
  }

  Map<String, dynamic> toJson(Usuario usuario) {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'username': username,
      'password': password,
      'cargo': cargo!.toJson(cargo!)
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, email: $email, username: $username, password: $password}, cargo: $cargo';
  }
}