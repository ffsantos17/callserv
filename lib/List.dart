import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Anuncio.dart';
import 'Data.dart';
import 'package:callcerv/Usuario.dart';
import 'package:url_launcher/url_launcher.dart';


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
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Color.fromRGBO(175, 175, 175, 1.0),
    ),
    width: double.infinity,
    height: 170,
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:

          case ConnectionState.done:
          // TODO: Handle this case.
            break;
        }
        final DocumentSnapshot doc = snapshot.data!.docs[index];
        String idVendedor = doc['vendedor'];
        CollectionReference users = FirebaseFirestore.instance.collection('dadosUsuarios');


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
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.home_repair_service,
                        color: secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(doc['categoria'],
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_circle_outlined,
                        color: secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: users.doc(idVendedor).get(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState == ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            return Text(data['username'],
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3));
                          }

                          return Text("loading");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on_outlined,
                        color: secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("R\$ ${doc['valor']}",
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(5),textStyle: const TextStyle(fontSize: 15),),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.call, size: 17),
                          ),
                          TextSpan(
                            text: " Contatar",
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Colors.red,
                            child: Center(
                              child: Container(
                                margin: new EdgeInsets.only(top: 20),
                                height: 180,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                  ),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Contatar Profissional',
                                    style: TextStyle(
                                    color: Colors.black, fontSize: 20, letterSpacing: .3)),
                                  const SizedBox(height: 20),
                                  FutureBuilder<DocumentSnapshot>(
                                    future: users.doc(idVendedor).get(),
                                    builder:
                                        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                                      if (snapshot.hasError) {
                                        return Text("Something went wrong");
                                      }

                                      if (snapshot.hasData && !snapshot.data!.exists) {
                                        return Text("Document does not exist");
                                      }

                                      if (snapshot.connectionState == ConnectionState.done) {
                                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(data['telefone'],
                                          style: const TextStyle(
                                          color: Colors.black, fontSize: 16, letterSpacing: .3)),

                                            FlatButton(
                                              child: Icon(Icons.call, size: 20, color: Colors.red,),
                                              onPressed: () => launch("tel:${data['telefone']}"),
                                            )
                                          ],
                                        );
                                      }

                                      return Text("loading");
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                    child: const Text('Fechar'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ),
                              ),

                            ),
                          );
                        },
                      );
                    },
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


