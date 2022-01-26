import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'anuncios.dart';

class DadosUsuario extends StatefulWidget {
  const DadosUsuario({Key? key}) : super(key: key);

  @override
  _DadosUsuarioState createState() => _DadosUsuarioState();
}

class _DadosUsuarioState extends State<DadosUsuario> {

  TextEditingController _controllerUname = TextEditingController();
  TextEditingController _controllerCell = TextEditingController();

  int selectRadio = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;


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
  String dropdownValue = 'AC';
  Widget build(BuildContext context) {
    User? usuarioLogado = auth.currentUser;
    String? idUsuarioLogado = usuarioLogado?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("CallServ"),
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
              controller: _controllerUname,
              decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.black)
              ),
            ),

            TextFormField(
              controller: _controllerCell,
              decoration: const InputDecoration(
                  labelText: "N.º Telefone",
                  labelStyle: TextStyle(color: Colors.black)
              ),
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            SizedBox(height: 30),
            Text("Estado"),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: Colors.black),

              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Text("Tipo de cadastro"),

            RadioListTile(
                title: const Text('Contratante'),
                subtitle: Text("Irei contratar os serviços"),
                value: 1,
                groupValue: selectRadio,
                activeColor: Colors.red,
                onChanged: (val){
                  print("$val");
                  setSelectRadio(val);
                }
            ),
            RadioListTile(
                title: const Text('Vendedor'),
                subtitle: Text("Irei oferecer meus serviços"),
                value: 2,
                groupValue: selectRadio,
                activeColor: Colors.red,
                onChanged: (val){
                  print("$val");
                  setSelectRadio(val);
                }
            ),


            ButtonTheme(
              height: 50.0,
              padding: EdgeInsets.only(left: 70, right: 70),
              child: RaisedButton(
                onPressed: () => { db.collection("dadosUsuarios").doc(idUsuarioLogado).set({"username" : _controllerUname.text, "telefone" : _controllerCell.text, "UF" : dropdownValue, "tipoUsuario" : selectRadio}).then((firebaseUser){Navigator.push(context, MaterialPageRoute(builder: (context) => Anuncios()),);})},
                shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(5.0)),
                child: const Text(
                  "Salvar",
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
