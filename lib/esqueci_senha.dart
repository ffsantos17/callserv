import 'package:callcerv/models/service.dart';
import 'package:flutter/material.dart';
import 'package:callcerv/Login.dart';

import 'package:callcerv/cadastro.dart';

import 'home.dart';

class EsqueciSenha extends StatelessWidget {
  const EsqueciSenha({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallServ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SenhaPage(title: 'CallServ'),
    );
  }
}



class SenhaPage extends StatefulWidget {
  const SenhaPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SenhaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Esqueci a senha',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            const SizedBox(height: 30),
            const Text(
              'Digite seu e-mail de cadastro abaixo e clique em enviar.',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(height: 50),
            const TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  labelText:"E-mail",
                  labelStyle: TextStyle(color: Colors.black),
                )
            ),
            const SizedBox(height: 20),
            ButtonTheme(
              height: 40.0,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(title: 'CallServ',)),) },
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(5.0)),

                child: const Text(
                  "Enviar",
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