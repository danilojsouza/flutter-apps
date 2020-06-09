import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:controle.tarefas/model/tarefa.dart';
import 'package:controle.tarefas/screens/tarefa.screen.dart';
import 'package:controle.tarefas/service/tarefas.service.dart';
import 'package:controle.tarefas/service/usuario.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InicioScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InicioScreenState();
}

class InicioScreenState extends State<InicioScreen> {
  TarefaService _tarefaService;
  UsuarioService _usuarioService;
  bool primeiraVez = true;

  @override
  void initState() {
    super.initState();
  }

  mensagem(String mensagem) {
    BotToast.showText(text: mensagem, contentColor: Colors.indigoAccent);
  }

  @override
  Widget build(BuildContext context) {
    _tarefaService = Provider.of<TarefaService>(context);
    _usuarioService = Provider.of<UsuarioService>(context);

    if (primeiraVez) {
      _tarefaService.lerJson();
      primeiraVez = false;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _usuarioService.lerUsuarioJson();
                Navigator.of(context).pushNamed("/usuario");
              }),
          title: Row(
            children: <Widget>[
              Expanded(child: Text("${_usuarioService.getNome()}")),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            content: Container(
                              height: 110,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Deslize uma tarefa para excluí-la.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Divider(color: Colors.indigoAccent),
                                  RaisedButton(
                                    child: Text("Apagar TODAS as Tarefas"),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                backgroundColor: Colors.indigo,
                                                title: Text(
                                                    "Apagar TODAS as Tarefas?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                content: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 28),
                                                  child: Row(
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        child: Text("Sim"),
                                                        color: Colors.redAccent,
                                                        onPressed: () {
                                                          _tarefaService
                                                              .removerTodasTarefa();
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          mensagem(
                                                              "Todas as tarefas foram apagadas!");
                                                        },
                                                      ),
                                                      RaisedButton(
                                                        child: Text("Não"),
                                                        color:
                                                            Colors.indigoAccent,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          mensagem("Cancelado");
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.indigo,
                            title: Text("Informação",
                                style: TextStyle(color: Colors.white)));
                      });
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor: Colors.indigo,
                            title: Text("Sair do aplicativo?",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white)),
                            content: Container(
                              padding: EdgeInsets.symmetric(horizontal: 28),
                              child: Row(
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text("Sim"),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      exit(0);
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Não"),
                                    color: Colors.indigoAccent,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ));
                      });
                },
              )
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Tarefas a fazer"),
              Tab(text: "Tarefas feitas")
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //Tarefas a fazer
            Observer(builder: (context) {
              if (_tarefaService.tarefaFazerStore.tarefas.isEmpty) {
                return Center(
                  child: Text("Sem atividades para exibir"),
                );
              }
              return ListView(
                children: _tarefaService.tarefaFazerStore.tarefas.map((tarefa) {
                  return Column(
                    children: <Widget>[
                      Dismissible(
                        child: CheckboxListTile(
                          activeColor: Colors.indigoAccent[100],
                          checkColor: Colors.indigo,
                          secondary: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TarefaScreen(
                                        acao: "Editar Tarefa a Fazer",
                                        tarefa: tarefa),
                                  ));
                            },
                          ),
                          subtitle: Text(
                              "ID: ${tarefa.id} - Criador: ${tarefa.criador.nome}\nPrazo: " +
                                  DateFormat('dd-MM-yyyy')
                                      .format(tarefa.prazo) +
                                  "\n${tarefa.descricao}"),
                          title: Text(tarefa.titulo),
                          value: tarefa.concluida,
                          onChanged: (value) {
                            _tarefaService.checkar(tarefa, value);
                            mensagem("Tarefa feita >");
                          },
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _tarefaService.removerTarefaFazer(tarefa);
                          mensagem("Tarefa a fazer excluída!");
                        },
                        background: Container(
                            color: Colors.red, child: Icon(Icons.delete)),
                      ),
                      Divider(color: Colors.indigoAccent),
                    ],
                  );
                }).toList(),
              );
            }),
            //Tarefas feitas
            Observer(builder: (context) {
              if (_tarefaService.tarefaFeitasStore.tarefas.isEmpty) {
                return Center(
                  child: Text("Sem atividades para exibir"),
                );
              }
              return ListView(
                children:
                    _tarefaService.tarefaFeitasStore.tarefas.map((tarefa) {
                  return Column(
                    children: <Widget>[
                      Dismissible(
                        child: CheckboxListTile(
                          activeColor: Colors.indigoAccent[100],
                          checkColor: Colors.indigo,
                          secondary: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TarefaScreen(
                                        acao: "Editar Tarefa Feita",
                                        tarefa: tarefa),
                                  ));
                            },
                          ),
                          subtitle: Text("ID: ${tarefa.id}\nPrazo: " +
                              DateFormat('dd-MM-yyyy').format(tarefa.prazo) +
                              "\n${tarefa.descricao}"),
                          title: Text(tarefa.titulo),
                          value: tarefa.concluida,
                          onChanged: (value) {
                            _tarefaService.checkar(tarefa, value);
                            mensagem("< Tarefa a fazer");
                          },
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _tarefaService.removerTarefaFeita(tarefa);
                          mensagem("Tarefa feita excluída!");
                        },
                        background: Container(
                            color: Colors.red, child: Icon(Icons.delete)),
                      ),
                      Divider(color: Colors.indigoAccent),
                    ],
                  );
                }).toList(),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TarefaScreen(acao: "Nova Tarefa", tarefa: Tarefa())));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
