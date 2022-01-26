import 'package:callcerv/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'DadosUsuario.dart';
import 'main.dart';

class cadastro extends StatelessWidget{
  const cadastro ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallServ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TCadastro(title: 'Cadastro CallServ'),
    );
  }

}


class TCadastro extends StatefulWidget {
  const TCadastro({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TCadastroState createState() => _TCadastroState();
}

class _TCadastroState extends State<TCadastro> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUname = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerCell = TextEditingController();

  int selectRadio = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;


  get $val => null;


  @override
  void initState(){
    super.initState();
    selectRadio = 0;
  }


  setSelectRadio(val){
    setState(() {
      selectRadio = val;
    });
  }

  @override
  FirebaseAuth auth = FirebaseAuth.instance;

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
              'CallServ',
              style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            TextField(
              controller: _controllerSenha,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.black)
              ),
            ),

            SizedBox(height: 30),
            ButtonTheme(
              height: 50.0,
              padding: EdgeInsets.only(left: 70, right: 70),
              child: RaisedButton(
                onPressed: () => { auth.createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerSenha.text).then((firebaseUser){Navigator.push(context, MaterialPageRoute(builder: (context) => DadosUsuario()),);}).catchError((erro){print("Erro");}) },
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(5.0)),
                child: const Text(
                  "CADASTRAR",
                  style: TextStyle(color: Colors.white, fontSize: 25),
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