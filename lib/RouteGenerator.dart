
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'anuncios.dart';
import 'package:callcerv/Login.dart';

import 'cadastro.dart';


class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => Anuncios()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => MyApp()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => cadastro()
        );
      default:
       return _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(
              title: Text("Tela não encontrada!"),
            ),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );

  }

}