import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:controle.tarefas/stores/usuario.store.dart';
import 'package:controle.tarefas/model/usuario.dart';

class UsuarioService {
  final UsuarioStore _usuarioStore;

  UsuarioService(this._usuarioStore);

  void remover(){
    _usuarioStore.remover();
    this.salvarUsuarioJson();
  }

  void adicionar(Usuario usuario){
    _usuarioStore.adicionar(usuario);
    this.salvarUsuarioJson();
    print("Usuário ${usuario.nome} adicionado!");
  }

  String getNome(){
    return _usuarioStore.usuario.nome;
  }

  Usuario getUsuario(){
    return _usuarioStore.usuario;
  }

  Future<Usuario> lerUsuarioJson() async {
    await new Future.delayed(const Duration(seconds : 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dadosUsuario = prefs.getString('usuario');

    if (dadosUsuario != null) {
      Map decodificado = jsonDecode(dadosUsuario);
      Usuario usuario = Usuario.fromJson(decodificado);
      _usuarioStore.adicionar(usuario);
      print("Usuário ${usuario.nome} lido do JSON.");
      return Future.value(usuario);
    }

    _usuarioStore.adicionar(Usuario("Usuário"));
    return Future.value(Usuario("Usuário"));
  }

  Future<Usuario> salvarUsuarioJson() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', jsonEncode(_usuarioStore.usuario));
    print("Usuario ${_usuarioStore.usuario.nome} salvo no Json...");
    return _usuarioStore.usuario;
  }

  void dispose() {}
}
