import 'package:flutter/material.dart';

class Artista {
  final String id;
  final String nome;
  final String imagem;
  final String email;
  final String senha;

  const Artista({
    @required this.id,
    @required this.nome,
    @required this.imagem,
    @required this.email,
    @required this.senha,
  });
}
