import 'package:callcerv/models/service.dart';
import 'package:flutter/material.dart';
import 'package:callcerv/Login.dart';

import 'package:callcerv/cadastro.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallServ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(title: 'CallServ'),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CallServ',
              style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Seja bem vindo',
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
            Image.asset("imagens/Service.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              ButtonTheme(
                  height: 40.0,
                  padding: EdgeInsets.only(left: 38, right: 38),
                  child: RaisedButton(
                    onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),) },
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(5.0)),

                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ), //Text
                    color:Colors.red,
                  ),//RaisedButton

                ),

                ButtonTheme(
                  height: 40.0,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => cadastro()),) },
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(5.0)),

                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ), //Text
                    color:Colors.red,
                  ),//RaisedButton

                ),
            ],
            ),




          ],
        ),


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}