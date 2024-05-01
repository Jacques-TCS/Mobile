class UsuarioModel {
  
  final int id;
  String nome, email, username, password;

  UsuarioModel({
    this.id = 0,
    this.nome = '',
    this.email = '',
    required this.username,
    required this.password
  });
  
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      username: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson(UsuarioModel usuario) {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'username': username,
      'password': password
    };
  }

  @override
  String toString() {
    return 'UsuarioModel{id: $id, nome: $nome, email: $email, username: $username, password: $password}';
  }
}