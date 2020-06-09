import 'dart:convert';
import 'package:controle.tarefas/model/tarefa.dart';
import 'package:controle.tarefas/stores/tarefa.fazer.store.dart';
import 'package:controle.tarefas/stores/tarefa.feitas.store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefaService {

  final TarefaFazerStore tarefaFazerStore;
  final TarefaFeitasStore tarefaFeitasStore;

  TarefaService(this.tarefaFazerStore, this.tarefaFeitasStore);

  Future<Tarefa> salvar(Tarefa tarefa){
    tarefaFazerStore.adicionar(tarefa);
    this.salvarJson();
    return Future.value(tarefa);
  }

  void removerTodasTarefa(){
    tarefaFeitasStore.removerTudo();
    tarefaFazerStore.removerTudo();
    this.salvarJson();
  }

  Future<Tarefa> removerTarefaFeita(Tarefa tarefa){
    tarefaFeitasStore.remover(tarefa);
    this.salvarJson();
    return Future.value(tarefa);
  }

  Future<Tarefa> removerTarefaFazer(Tarefa tarefa){
    tarefaFazerStore.remover(tarefa);
    this.salvarJson();
    return Future.value(tarefa);
  }

  Future<Tarefa> atualizar(Tarefa tarefaVelha, Tarefa tarefaNova){
    if(!tarefaNova.concluida){
      tarefaFazerStore.atualizar(tarefaNova, tarefaVelha);
    }else{
      tarefaFeitasStore.atualizar(tarefaNova, tarefaVelha);
    }
    this.salvarJson();
    return Future.value(tarefaNova);
  }

  void checkar(Tarefa tarefaVelha, bool){
    Tarefa tarefaNova = tarefaVelha;
    if(!tarefaVelha.concluida)
      tarefaFeitasStore.atualizar(tarefaFazerStore.checkar(tarefaNova, bool), tarefaVelha);
    else
      tarefaFazerStore.atualizar(tarefaFeitasStore.checkar(tarefaNova, bool), tarefaVelha);
    this.salvarJson();
  }

  Future lerJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dadosTarefasFeitas = prefs.getString('tarefas_feitas');
    var dadosTarefasFazer = prefs.getString('tarefas_fazer');

    if (dadosTarefasFeitas != null) {
      Iterable decodificado = jsonDecode(dadosTarefasFeitas);
      List<Tarefa> tarefasFeitas = decodificado.map((tarefa) => Tarefa.fromJson(tarefa)).toList();
      tarefaFeitasStore.tarefas = tarefasFeitas.asObservable();
    }

    if (dadosTarefasFazer != null) {
      Iterable decodificado = jsonDecode(dadosTarefasFazer);
      List<Tarefa> tarefasFazer = decodificado.map((tarefa) => Tarefa.fromJson(tarefa)).toList();
      print("${tarefasFazer.length}");
      tarefaFazerStore.tarefas = tarefasFazer.asObservable();
    }

    print("Tarefas carregadas do Json...");
  }

  Future salvarJson() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('tarefas_feitas', jsonEncode(tarefaFeitasStore.tarefas));
    await prefs.setString('tarefas_fazer', jsonEncode(tarefaFazerStore.tarefas));
    print("Tarefas salvas no Json...");
  }

  void dispose(){
  }
}