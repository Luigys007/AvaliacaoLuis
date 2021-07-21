import 'package:flutter/material.dart';
import '../models/musicas.dart';
import '../providers/musicas_providers.dart';
import 'package:provider/provider.dart';

class TelaEditMusicas extends StatefulWidget {
  @override
  TelaEditMusicasState createState() => TelaEditMusicasState();
}

class TelaEditMusicasState extends State<TelaEditMusicas> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Musicas musica) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novaMusica = Musicas(
      id: musica.id,
      nomeMusica: dadosForm['nomeMusica'],
      duracao: dadosForm['duracao'],
      estilo: dadosForm['estilo'],
      id_artista: musica.id_artista,
    );

    if (formValido) {
      Provider.of<MusicasProvider>(context, listen: false).patchMusica(novaMusica);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicas = ModalRoute.of(context).settings.arguments as Musicas;
    print(musicas);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Musica"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, musicas);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Musica'),
                initialValue: musicas.nomeMusica,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['nomeMusica'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um nome valido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duração'),
                textInputAction: TextInputAction.next,
                initialValue: musicas.duracao,
                onSaved: (value) {
                  dadosForm['duracao'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe uma duração válida";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estilo'),
                textInputAction: TextInputAction.next,
                initialValue: musicas.estilo,
                onSaved: (value) {
                  dadosForm['estilo'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, musicas);
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um valor válido";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
