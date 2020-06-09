import 'package:controle.tarefas/model/usuario.dart';
import 'package:controle.tarefas/service/usuario.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioScreen extends StatefulWidget {
  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final controlador = TextEditingController();
  UsuarioService usuarioService;

  nomearUsuario() {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                color: Colors.white12,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, size: 100),
                    SizedBox(height: 5.0),
                    Text("Seja bem-vindo!", style: style, textAlign: TextAlign.center),
                    SizedBox(height: 30.0),
                    Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: controlador,
                          style: style,
                          maxLength: 25,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Nome",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(height: 45.0),
                        OutlineButton(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text("Entrar", style: style),
                          onPressed: () {
                            usuarioService.adicionar(Usuario(controlador.text));
                            Navigator.of(context).pushNamed("/inicio");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  usuarioNomeado(Usuario usuario) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                color: Colors.white12,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, size: 100),
                    SizedBox(height: 5.0),
                    Text("${usuario.nome}\nSeja bem-vindo!", style: style, textAlign: TextAlign.center),
                    SizedBox(height: 45.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text("Entrar", style: style),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/inicio");
                          },
                        ),
                        OutlineButton(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text("Trocar usuário", style: style),
                          onPressed: () {
                            usuarioService.remover();
                            Navigator.of(context).pushNamed("/usuario");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    usuarioService = Provider.of<UsuarioService>(context);

    return FutureBuilder(
        future: usuarioService.lerUsuarioJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (usuarioService.getNome() != "Usuário")
              return usuarioNomeado(usuarioService.getUsuario());
            else
              return nomearUsuario();
          } else {
            return Scaffold(
                backgroundColor: Colors.indigo,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      color: Colors.white12,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Carregando usuários e tarefas..."),
                            CircularProgressIndicator(),
                          ],
                        ),
                    ),
                  ),
                )
                )
            );
          }
        });
  }
}