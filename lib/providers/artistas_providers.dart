import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/artista.dart';
import 'package:http/http.dart' as http;
import '../utils/variaveis.dart';

class ArtistaProvider with ChangeNotifier {
  List<Artista> _artista = [];

  List<Artista> get getArtista => [..._artista];

  void adicionarArtista(Artista artista) {
    _artista.add(artista);
    notifyListeners();
  }

  Future<void> postArtistas(Artista artista) async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas.json');
    http
        .post(url,
            body: jsonEncode(
              {
                'nome': artista.nome,
                'imagem': artista.imagem,
                'email': artista.email,
                'senha': artista.senha
              },
            ))
        .then((value) {
      adicionarArtista(artista);
    });
  }

  //MÉTODO PARA ATUALIZAR MONTADORAS
  Future<void> patchArtista(Artista artista) async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas/${artista.id}.json');
    http
        .patch(url,
            body: jsonEncode(
              {
                'nome': artista.nome,
                'imagem': artista.imagem,
                'email': artista.email,
                'senha': artista.senha
              },
            ))
        .then((value) {
      buscaArtista();
      notifyListeners();
    });
  }

  //MÉTODO PARA APAGAR MONTADORAS
  Future<void> deleteArtista(Artista artista) async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas/${artista.id}.json');
    http.delete((url)).then((value) {
      buscaArtista();
      notifyListeners();
    });
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaArtista() async {
    var url = Uri.https(Variaveis.BACKURL, '/artistas.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _artista.clear();
    print(data);
    if (data.isNotEmpty) {
      data.forEach((idArtista, dadosArtista) {
        adicionarArtista(Artista(
          id: idArtista,
          nome: dadosArtista['nome'],
          imagem: dadosArtista['imagem'],
          email: dadosArtista['email'],
          senha: dadosArtista['senha'],
        ));
      });
      notifyListeners();
    }
  }
}
