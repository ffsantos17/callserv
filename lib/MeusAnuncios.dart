import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Data.dart';
import 'List.dart';
import 'ListMeusAnuncios.dart';
import 'cadastroAnuncio.dart';

class MeusAnuncios extends StatefulWidget {
  const MeusAnuncios({Key? key}) : super(key: key);

  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection(
    'dadosUsuarios');



class _MeusAnunciosState extends State<MeusAnuncios> {

  final _controller = StreamController<QuerySnapshot>.broadcast();

  @override
  Widget build(BuildContext context) {
    User? usuarioAtual = auth.currentUser;
    String? idUsuarioLogado = usuarioAtual?.uid;
    String? emailUsuarioLogado = usuarioAtual?.email;

    Stream<QuerySnapshot> _getList(){
      return db.collection("meus_anuncios").doc(idUsuarioLogado).collection("anuncios").snapshots();;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
      ),
      body: Center(
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:

                      case ConnectionState.done:
                      // TODO: Handle this case.
                        break;
                    }
                    int cont = snapshot.data!.docs.length;
                    if (cont > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return userListMeus(context, index);
                          });
                    }else{
                      return const Text("Nenhum anuncio cadastrado",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroAnuncio()),
          );
        },
        tooltip: 'Novo Anuncio',
        child: Icon(Icons.add),
      ),
    );
  }
}
