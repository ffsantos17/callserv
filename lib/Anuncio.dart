
import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio{

  String _id = 'a';
  String _servico = 'a';
  String _categoria = 'a';
  String _NF = 'a';
  String _valor = 'a';


  Anuncio();

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.id;
    this.servico = documentSnapshot["servico"];
    this.categoria = documentSnapshot["categoria"];
    this.NF     = documentSnapshot["NF"];
    this.valor      = documentSnapshot["valor"];


  }


  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "servico" : this.servico,
      "categoria" : this.categoria,
      "NF" : this.NF,
      "valor" : this.valor,

    };

    return map;

  }



  String get valor => _valor;

  set valor(String value) {
    _valor = value;
  }

  String get NF => _NF;

  set NF(String value) {
    _NF = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get servico => _servico;

  set servico(String value) {
    _servico = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}