import 'package:flutter/material.dart';
import '../componentes/drawer_personalizado.dart';
import '../componentes/item_artista.dart';
import '../componentes/item_musicas.dart';
import '../models/musicas.dart';
import '../models/artista.dart';
import '../providers/musicas_providers.dart';
import '../providers/artistas_providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaMusicas extends StatefulWidget {
  @override
  _TelaMusicasState createState() => _TelaMusicasState();
}

class _TelaMusicasState extends State<TelaMusicas> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context, Artista artista) {
    return Provider.of<ArtistaProvider>(context, listen: false).buscaArtista();
  }

  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    final musicas = Provider.of<MusicasProvider>(context).getArtista;
    Provider.of<MusicasProvider>(context).buscaMusica(artista);
    print(musicas);
    return Scaffold(
      appBar: AppBar(
        title: Text("Artista - ${artista.nome}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                Rotas.FORM_MUSICAS,
                arguments: artista,
              );
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context, artista),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: musicas.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaMusicas(musicas[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
