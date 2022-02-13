
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{

  String _id = '';
  String _username = '';
  String _tipo = '';
  String _telefone = '';
  String _uf = '';


  Usuario();

  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.id;
    this.username = documentSnapshot["username"];
    this.tipo = documentSnapshot["tipoUsuario"];
    this.uf     = documentSnapshot["UF"];
    this.telefone   = documentSnapshot["telefone"];

  }


  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "username" : this.username,
      "tipoUser" : this.tipo,
      "UF" : this.uf,
      "telefone" : this.telefone,
    };

    return map;

  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }


  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get uf => _uf;

  set uf(String value) {
    _uf = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}