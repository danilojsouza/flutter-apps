// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioStore on _UsuarioStore, Store {
  final _$usuarioAtom = Atom(name: '_UsuarioStore.usuario');

  @override
  Usuario get usuario {
    _$usuarioAtom.context.enforceReadPolicy(_$usuarioAtom);
    _$usuarioAtom.reportObserved();
    return super.usuario;
  }

  @override
  set usuario(Usuario value) {
    _$usuarioAtom.context.conditionallyRunInAction(() {
      super.usuario = value;
      _$usuarioAtom.reportChanged();
    }, _$usuarioAtom, name: '${_$usuarioAtom.name}_set');
  }

  final _$_UsuarioStoreActionController =
      ActionController(name: '_UsuarioStore');

  @override
  void adicionar(Usuario usuario) {
    final _$actionInfo = _$_UsuarioStoreActionController.startAction();
    try {
      return super.adicionar(usuario);
    } finally {
      _$_UsuarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remover() {
    final _$actionInfo = _$_UsuarioStoreActionController.startAction();
    try {
      return super.remover();
    } finally {
      _$_UsuarioStoreActionController.endAction(_$actionInfo);
    }
  }
}
