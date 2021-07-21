import 'package:flutter/material.dart';
import 'package:avaliacaoluis/telas/tela_edit_musicas.dart';
import 'telas/tela_form_artistas.dart';
import 'providers/artistas_providers.dart';
import 'providers/musicas_providers.dart';
import 'telas/tela_artistas.dart';
import 'telas/tela_musicas.dart';
import 'telas/tela_form_musicas.dart';
import 'utils/rotas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ArtistaProvider(),
      child: ChangeNotifierProvider(
        create: (ctx) => MusicasProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.yellow),
          routes: {
            Rotas.HOME: (ctx) => TelaArtistas(),
            Rotas.FORM_ARTISTA: (ctx) => TelaFormArtista(),
            Rotas.TELA_MUSICAS: (ctx) => TelaMusicas(),
            Rotas.FORM_MUSICAS: (ctx) => TelaFormMusicas(),
            Rotas.EDIT_MUSICAS: (ctx) => TelaEditMusicas(),
          },
          onGenerateRoute: (settings) {
            print(settings.name);
            return null;
          },
          onUnknownRoute: (settings) {
            print("Rota não encontrada");
            return null;
          },
        ),
      ),
    );
  }
}
