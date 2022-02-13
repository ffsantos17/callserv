class ListaAdvogado extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var snapshots =
    FirebaseFirestore.instance.collection('advogado').snapshots();

    Advogado advogado = Advogado();
    DBAdvogado advogados = DBAdvogado();
    String documentId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Advogados'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                RotasApp.FORM_ADVOGADO,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: snapshots,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data.docs.length == 0) {
            return Center(child: Text('Nenhuma tarefa ainda'));
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, i) {
                var lista = snapshot.data.docs[i].data();
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(lista['nome']),
                  subtitle: Text(lista['email']),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              RotasApp.FORM_ADVOGADO,
                              arguments: advogado,
                              //advogado
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Excluir Advogado'),
                                content: Text('Tem certeza???'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Não'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                  FlatButton(
                                    child: Text('Sim'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                  ),
                                ],
                              ),
                            ).then((confirmed) async {
                              if (confirmed) {
                                await advogados.delete(documentId);                                  }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}