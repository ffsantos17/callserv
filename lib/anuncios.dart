import 'package:callcerv/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:callcerv/Login.dart';

import 'package:callcerv/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Data.dart';
import 'List.dart';
import 'home.dart';

class Anuncios extends StatelessWidget {
  const Anuncios({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallServ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AnunciosPage(title: 'CallServ'),
    );
  }
}



class AnunciosPage extends StatefulWidget {
  const AnunciosPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AnunciosPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    User? usuarioAtual = auth.currentUser;
    String? idUsuarioLogado = usuarioAtual?.uid;
    if(usuarioAtual != null){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {auth.signOut();Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()),);},
            child: const Text('Sair'),
          ),
        ],
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
                child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return userList(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text("nome"),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                height: 40.0,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: RaisedButton(
                  onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),) },
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(5.0)),

                  child: const Text(
                    "Logar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ), //Text
                  color:Colors.red,
                ),//RaisedButton

              ),

            ],


          ),


        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

}