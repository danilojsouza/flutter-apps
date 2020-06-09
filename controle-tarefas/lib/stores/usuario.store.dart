import 'package:mobx/mobx.dart';
import 'package:controle.tarefas/model/usuario.dart';
part 'usuario.store.g.dart';

class UsuarioStore = _UsuarioStore with _$UsuarioStore;

abstract class _UsuarioStore with Store {

  @observable
  Usuario usuario;

  @action
  void adicionar(Usuario usuario) {
    this.usuario = usuario;
  }

  @action
  void remover() {
    this.usuario = Usuario("Usuário");
  }
}