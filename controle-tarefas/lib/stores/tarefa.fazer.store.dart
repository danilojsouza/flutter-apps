import 'package:mobx/mobx.dart';
import 'package:controle.tarefas/model/tarefa.dart';
part 'tarefa.fazer.store.g.dart';

class TarefaFazerStore = _TarefaFazerStore with _$TarefaFazerStore;

abstract class _TarefaFazerStore with Store {

  @observable
  ObservableList<Tarefa> tarefas = List<Tarefa>().asObservable();

  int totalTarefas = 0;

  @action
  void adicionar(Tarefa tarefa) {
    tarefa.id = totalTarefas;
    tarefa.concluida = false;
    this.tarefas = [...tarefas, tarefa].asObservable();
    totalTarefas++;
  }

  @action
  void remover(Tarefa tarefa) {
    this.tarefas.remove(tarefa);
  }

  @action
  void removerTudo() {
    this.tarefas.clear();
  }

  @action
  Tarefa checkar(Tarefa tarefavelha, bool) {
    remover(tarefavelha);
    tarefavelha.concluida = bool;
    return tarefavelha;
  }

  @action
  void atualizar(Tarefa tarefaNova, Tarefa tarefaVelha) {
    this.tarefas.remove(tarefaVelha);
    this.tarefas.add(tarefaNova);
  }
}