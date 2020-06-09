import 'package:mobx/mobx.dart';
import 'package:controle.tarefas/model/tarefa.dart';
part 'tarefa.feitas.store.g.dart';

class TarefaFeitasStore = _TarefaFeitasStore with _$TarefaFeitasStore;

abstract class _TarefaFeitasStore with Store {

  @observable
  ObservableList<Tarefa> tarefas = List<Tarefa>().asObservable();

  int totalTarefas = 0;

  @
  action
  void remover(Tarefa tarefa) {
    this.tarefas.remove(tarefa);
  }

  @action
  void removerTudo() {
    this.tarefas.clear();
  }

  @action
  Tarefa checkar(Tarefa tarefaVelha, bool) {
    remover(tarefaVelha);
    tarefaVelha.concluida = bool;
    return tarefaVelha;
  }

  @action
  void atualizar(Tarefa tarefaNova, Tarefa tarefaVelha) {
    this.tarefas.remove(tarefaVelha);
    this.tarefas.add(tarefaNova);
  }
}