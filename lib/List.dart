import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Anuncio.dart';
import 'Data.dart';
import 'package:callcerv/Usuario.dart';


final primary = Colors.indigo;
final secondary = Colors.black;
final background = Colors.white10;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection(
    'dadosUsuarios');


Stream<QuerySnapshot> _getList() {
  return db.collection('anuncios').snapshots();
}

User? usuarioAtual = auth.currentUser;
String? idUsuarioLogado = usuarioAtual?.uid;
String? emailUsuarioLogado = usuarioAtual?.email;


Stream documentStream = FirebaseFirestore.instance.collection('anuncios')
    .snapshots();

Widget userList(BuildContext context, int index) {

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Colors.black12,
    ),
    width: double.infinity,
    height: 120,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: StreamBuilder<QuerySnapshot>(
      stream: _getList(),
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          // TODO: Handle this case.
            break;
          case ConnectionState.waiting:
          // TODO: Handle this case.
            break;
          case ConnectionState.active:

          case ConnectionState.done:
          // TODO: Handle this case.
            break;
        }
        final DocumentSnapshot doc = snapshot.data!.docs[index];

        String idVendedor = doc['vendedor'];
        return Row(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.only(right: 15),
                  child: Image(image: AssetImage('imagens/Service.png'))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    doc['servico'],
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.home_repair_service,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(doc['categoria'],
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on_outlined,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(doc['valor'],
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}


