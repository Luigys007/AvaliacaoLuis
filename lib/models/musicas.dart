import 'package:flutter/material.dart';

class Musicas {
  final String id;
  final String nomeMusica;
  final String duracao;
  final String estilo;
  final String id_artista;

  const Musicas({
    this.id,
    @required this.nomeMusica,
    @required this.duracao,
    @required this.estilo,
    @required this.id_artista,
  });
}
