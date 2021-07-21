import 'package:flutter/material.dart';
import '../models/musicas.dart';
import '../providers/musicas_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemListaMusicas extends StatelessWidget {
  final Musicas musica;

  ItemListaMusicas(this.musica);

  void deleteMusica(context, Musicas musica) {
    Provider.of<MusicasProvider>(context, listen: false).deleteMusica(musica);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      tileColor: Colors.yellow[200],
      title: Container(
        child: Text(
          musica.nomeMusica,
          style: TextStyle(color: Colors.black),
        ),
        
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Rotas.EDIT_MUSICAS,
                    arguments: musica,
                  );
                },
                color: Colors.black,
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("ATENÇÃO"),
                      content: Text("Está certo disso?"),
                      actions: [
                        TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              deleteMusica(context, musica);
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                },
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
