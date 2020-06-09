// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa.feitas.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaFeitasStore on _TarefaFeitasStore, Store {
  final _$tarefasAtom = Atom(name: '_TarefaFeitasStore.tarefas');

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

  final _$_TarefaFeitasStoreActionController =
      ActionController(name: '_TarefaFeitasStore');

  @override
  void remover(Tarefa tarefa) {
    final _$actionInfo = _$_TarefaFeitasStoreActionController.startAction();
    try {
      return super.remover(tarefa);
    } finally {
      _$_TarefaFeitasStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerTudo() {
    final _$actionInfo = _$_TarefaFeitasStoreActionController.startAction();
    try {
      return super.removerTudo();
    } finally {
      _$_TarefaFeitasStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Tarefa checkar(Tarefa tarefaVelha, dynamic bool) {
    final _$actionInfo = _$_TarefaFeitasStoreActionController.startAction();
    try {
      return super.checkar(tarefaVelha, bool);
    } finally {
      _$_TarefaFeitasStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void atualizar(Tarefa tarefaNova, Tarefa tarefaVelha) {
    final _$actionInfo = _$_TarefaFeitasStoreActionController.startAction();
    try {
      return super.atualizar(tarefaNova, tarefaVelha);
    } finally {
      _$_TarefaFeitasStoreActionController.endAction(_$actionInfo);
    }
  }
}
