import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'anuncios.dart';
import 'esqueci_senha.dart';

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallServ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Login CallServ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 26, left: 10, right: 10),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CallServ',
              style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextField(
                controller: _controllerEmail,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: const InputDecoration(
                  labelText:"email do usuário",
                  labelStyle: TextStyle(color: Colors.black),
                )
            ),
            TextField(
                controller: _controllerSenha,
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: const InputDecoration(
                  labelText:"Senha do usuário",
                  labelStyle: TextStyle(color: Colors.black),
                )
            ),
            const SizedBox(height: 40),
            ButtonTheme(
              height: 50.0,
              padding: EdgeInsets.only(left: 70, right: 70),

              child: RaisedButton(
                  onPressed: () => { auth.signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerSenha.text).then((firebaseUser){Navigator.push(context, MaterialPageRoute(builder: (context) => Anuncios()),);}).catchError((erro){print("Erro");}) },
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(5.0)),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ), //Text
                color:Colors.red,
              ),//RaisedButton
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => SenhaPage(title: 'CallServ',)),)},
              child: const Text('Esqueci a Senha'),
            ),

          ],

        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
