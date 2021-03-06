import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

import 'MeusAnuncios.dart';

class CadastroAnuncio extends StatefulWidget {
  const CadastroAnuncio({Key? key}) : super(key: key);

  @override
  _CadastroAnuncioState createState() => _CadastroAnuncioState();
}

class _CadastroAnuncioState extends State<CadastroAnuncio> {
  TextEditingController _controllerServico = TextEditingController();
  TextEditingController _controllerValor = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String dropdownValue = 'Assistência técnica';
  int selectRadio = 0;
  void initState(){
    super.initState();
    selectRadio = 0;
  }


  setSelectRadio(val){
    setState(() {
      selectRadio = val;
    });
  }

  _abrirDialog(BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Column(children: const <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text("Salvando Anuncio")
            ],)
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    User? usuarioLogado = auth.currentUser;
    String? idUsuarioLogado = usuarioLogado?.uid;
    CollectionReference anuncios = db.collection("meus_anuncios");
    String idAnuncio = anuncios.doc().id;

    int selectRadio = 2;


    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar anúncio"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controllerServico,
              decoration: const InputDecoration(
                  labelText: "Serviço",
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: _controllerValor,
              decoration: const InputDecoration(
                  labelText: "Valor",
                  labelStyle: TextStyle(color: Colors.black)),
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Catégoria do serviço"),
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
              items: <String>[
                'Assistência técnica',
                'Reformas e reparos',
                'Serviços Domésticos'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            const Text("Emite Nota Fiscal?"),
            RadioListTile(
                title: const Text('Sim'),
                value: 1,
                groupValue: selectRadio,
                activeColor: Colors.red,
                onChanged: (val) {
                  print("$val");
                  setSelectRadio(val);
                }),
            RadioListTile(
                title: const Text('Não'),
                value: 2,
                groupValue: selectRadio,
                activeColor: Colors.red,
                onChanged: (val) {
                  print("$val");
                  setSelectRadio(val);
                }),
            ButtonTheme(
              height: 50.0,
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: RaisedButton(
                onPressed: () => {

                  if(_controllerServico.text == '' || _controllerValor.text == ''){
                        showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Atenção"),
                          content: const Text("Preencha todos os campos do anúncio"),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Ok'),
                              onPressed: () =>
                                  Navigator.of(ctx).pop(false),
                            ),
                          ],
                        ),
                      ),
                  }else{
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      db.collection("meus_anuncios").doc(idUsuarioLogado)
                          .collection("anuncios").doc(idAnuncio).set({
                        "servico": _controllerServico.text,
                        "valor": _controllerValor.text,
                        "categoria": dropdownValue,
                        "NF": selectRadio,
                        "vendedor": idUsuarioLogado
                      })
                          .then((_) {
                        db.collection("anuncios").doc(idAnuncio).set({
                          "servico": _controllerServico.text,
                          "valor": _controllerValor.text,
                          "categoria": dropdownValue,
                          "NF": selectRadio,
                          "vendedor": idUsuarioLogado
                        }).then((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeusAnuncios()),
                          );
                        });
                      })
                    },
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white, fontSize: 25),
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
