import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? uid; // Identificador único do usuário no Firebase
  String? email;
  String? password;
  String? nome;
  String? sobrenome;
  DateTime? dataNascimento;
  String? fotoPerfil;
  

  Usuario({
    this.uid,
    this.email,
    this.password,
    this.nome,
    this.sobrenome,
    this.dataNascimento,
    this.fotoPerfil,
    
  });

  // Construtor para criar um objeto Usuario a partir de um mapa (por exemplo, um documento do Firestore)
  factory Usuario.fromMap(Map<String, dynamic> data) {
    return Usuario(
      uid: data['uid'],
      email: data['email'],
      password: data['password'],
      nome: data['nome'],
      sobrenome: data['sobrenome'],
      dataNascimento: (data['dataNascimento'] as Timestamp?)?.toDate(),
      fotoPerfil: data['fotoPerfil'],
      // ... outros atributos
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      dataNascimento: (json['dataNascimento'] as Timestamp?)?.toDate(),
      fotoPerfil: json['fotoPerfil'],
    );
  }

  
}