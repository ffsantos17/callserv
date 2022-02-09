import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Data.dart';
import 'List.dart';

class MeusAnuncios extends StatefulWidget {
  const MeusAnuncios({Key? key}) : super(key: key);

  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {

  final _controller = StreamController<QuerySnapshot>.broadcast();

  FirebaseFirestore db = FirebaseFirestore.instance;

  late String _idUsuarioLogado;
  _recuperaDadosUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioAtual = auth.currentUser;
    _idUsuarioLogado = usuarioAtual!.uid;

  }

  Stream<QuerySnapshot> _getList(){
    return db.collection("meusAnuncios").doc("6lKBzQZtsTNjgNvFqufEdEOhoy33").collection("anuncios").snapshots();;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anuncios"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
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


                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return userList(context, index);
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
