import 'package:flutter/material.dart';

import 'Data.dart';

final primary = Colors.indigo;
final secondary = Colors.black;
final background = Colors.white10;

Widget userList(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Colors.black12,
    ),
    width: double.infinity,
    height: 120,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 15),
              child: Image(image: AssetImage('imagens/Service.png'))),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                services[index]['nome'],
                style: TextStyle(
                    color: primary, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.home_repair_service,
                    color: secondary,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(services[index]['servico'],
                      style: TextStyle(
                          color: primary, fontSize: 13, letterSpacing: .3)),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.monetization_on_outlined,
                    color: secondary,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(services[index]['Valor'],
                      style: TextStyle(
                          color: primary, fontSize: 13, letterSpacing: .3)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}