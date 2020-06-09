// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa.fazer.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaFazerStore on _TarefaFazerStore, Store {
  final _$tarefasAtom = Atom(name: '_TarefaFazerStore.tarefas');

  @override
  ObservableList<Tarefa> get tarefas {
    _$tarefasAtom.context.enforceReadPolicy(_$tarefasAtom);
    _$tarefasAtom.reportObserved();
    return super.tarefas;
  }

  @override
  set tarefas(ObservableList<Tarefa> value) {
    _$tarefasAtom.context.conditionallyRunInAction(() {
      super.tarefas = value;
      _$tarefasAtom.reportChanged();
    }, _$tarefasAtom, name: '${_$tarefasAtom.name}_set');
  }

  final _$_TarefaFazerStoreActionController =
      ActionController(name: '_TarefaFazerStore');

  @override
  void adicionar(Tarefa tarefa) {
    final _$actionInfo = _$_TarefaFazerStoreActionController.startAction();
    try {
      return super.adicionar(tarefa);
    } finally {
      _$_TarefaFazerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remover(Tarefa tarefa) {
    final _$actionInfo = _$_TarefaFazerStoreActionController.startAction();
    try {
      return super.remover(tarefa);
    } finally {
      _$_TarefaFazerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerTudo() {
    final _$actionInfo = _$_TarefaFazerStoreActionController.startAction();
    try {
      return super.removerTudo();
    } finally {
      _$_TarefaFazerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Tarefa checkar(Tarefa tarefavelha, dynamic bool) {
    final _$actionInfo = _$_TarefaFazerStoreActionController.startAction();
    try {
      return super.checkar(tarefavelha, bool);
    } finally {
      _$_TarefaFazerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void atualizar(Tarefa tarefaNova, Tarefa tarefaVelha) {
    final _$actionInfo = _$_TarefaFazerStoreActionController.startAction();
    try {
      return super.atualizar(tarefaNova, tarefaVelha);
    } finally {
      _$_TarefaFazerStoreActionController.endAction(_$actionInfo);
    }
  }
}
