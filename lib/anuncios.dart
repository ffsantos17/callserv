import 'dart:async';

import 'package:callcerv/MeusAnuncios.dart';
import 'package:callcerv/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:callcerv/Login.dart';

import 'package:callcerv/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Data.dart';
import 'List.dart';
import 'cadastroAnuncio.dart';
import 'home.dart';
import 'package:callcerv/DadosUsuario.dart';
import 'package:callcerv/Usuario.dart';

class Anuncios extends StatefulWidget {
  const Anuncios({Key? key}) : super(key: key);

  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users =
  FirebaseFirestore.instance.collection('dadosUsuarios');

  Stream<QuerySnapshot> _getList() {
    return db.collection('anuncios').snapshots();
  }


  @override
  Widget build(BuildContext context) {
    User? usuarioAtual = auth.currentUser;
    String? idUsuarioLogado = usuarioAtual?.uid;
    String? emailUsuarioLogado = usuarioAtual?.email;

    String LetraString = emailUsuarioLogado!.substring(0,2);
    FirebaseFirestore.instance
        .collection('dadosUsuarios')
        .doc(idUsuarioLogado)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get(FieldPath(['username']));
    });

    CollectionReference users = FirebaseFirestore.instance.collection('dadosUsuarios');



    if (usuarioAtual != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Anuncios"),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
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
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountEmail: Text(emailUsuarioLogado),
                accountName:     FutureBuilder<DocumentSnapshot>(
                  future: users.doc(idUsuarioLogado).get(),
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
                      return Text(data['username']);
                    }

                    return Text("loading");
                  },
                ),
                currentAccountPicture: CircleAvatar(
                  child: Text(LetraString),
                ),
              ),
              ListTile(
                title: const Text('Meus anuncios'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeusAnuncios()),
                  );
                },
              ),
              ListTile(
                title: const Text('Sair'),
                onTap: () {
                  auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHome()),
                  );
                },
              ),
            ],
          ),
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Anuncios'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                height: 40.0,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    )
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),

                  child: const Text(
                    "Logar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ), //Text
                  color: Colors.red,
                ), //RaisedButton
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }
}
