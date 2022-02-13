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




Widget userListMeus(BuildContext context, int index) {
  User? usuarioAtual = auth.currentUser;
  String? idUsuarioLogado = usuarioAtual?.uid;
  String? emailUsuarioLogado = usuarioAtual?.email;

  Stream<QuerySnapshot> _getList() {
    return db.collection('meus_anuncios').doc(idUsuarioLogado).collection('anuncios').snapshots();
  }



  Stream documentStream = FirebaseFirestore.instance.collection('meus_anuncios')
      .doc(idUsuarioLogado)
      .collection('anuncios')
      .snapshots();

  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Colors.black12,
    ),
    width: double.infinity,
    height: 167,
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
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.all(5),textStyle: const TextStyle(fontSize: 12),),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.delete, size: 17),
                          ),
                          TextSpan(
                            text: " Deletar",
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Excluir anúncio"),
                          content: Text("Tem certeza que deseja excluir o anúncio ${doc['servico']}?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () =>
                                  Navigator.of(ctx).pop(false),
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                String docID = doc.id;
                                db.collection('meus_anuncios').doc(idUsuarioLogado).collection('anuncios').doc(docID).delete();
                                db.collection('anuncios').doc(docID).delete();
                                Navigator.of(ctx).pop(true);
                                },
                            ),
                          ],
                        ),
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


