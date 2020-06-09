import 'package:bot_toast/bot_toast.dart';
import 'package:controle.tarefas/model/tarefa.dart';
import 'package:controle.tarefas/service/tarefas.service.dart';
import 'package:controle.tarefas/service/usuario.service.dart';
import 'package:controle.tarefas/widgets/form/date_time_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TarefaScreen extends StatefulWidget {
  final String acao;
  final Tarefa tarefa;
  TarefaScreen({@required this.acao, this.tarefa});

  @override
  TarefaScreenState createState() => TarefaScreenState(tarefa: this.tarefa);
}

class TarefaScreenState extends State<TarefaScreen> {
  Tarefa tarefa;
  TarefaScreenState({@required this.tarefa});
  final _formKey = GlobalKey<FormState>();
  TarefaService _tarefaService;
  UsuarioService _usuarioService;

  String _titulo;
  String _descricao;
  DateTime _prazo;

  FocusNode _focusTitulo;
  FocusNode _focusDescricao;
  FocusNode _focusPrazo;

  @override
  void initState() {
    super.initState();
    this._focusTitulo = FocusNode();
    this._focusDescricao = FocusNode();
    this._focusPrazo = FocusNode();
  }

  @override
  void dispose() {
    this._focusTitulo.dispose();
    this._focusDescricao.dispose();
    this._focusPrazo.dispose();
    super.dispose();
  }

  mensagem(String mensagem) {
    BotToast.showText(text: mensagem, contentColor: Colors.indigoAccent);
  }

  _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Tarefa tarefaNova = Tarefa(
        id: tarefa.id,
          titulo: this._titulo,
          descricao: this._descricao,
          prazo: this._prazo,
      concluida: tarefa.concluida,
      criador: (tarefa.criador != null) ? tarefa.criador  : _usuarioService.getUsuario());

      //Nova Tarefa
      if(tarefaNova.id == null){
        this._tarefaService.salvar(tarefaNova).then((value) {
        mensagem("Tarefa ${value.titulo} Adicionada!");
        });
      }else{
        //Editar Tarefa
        this._tarefaService.atualizar(tarefa, tarefaNova).then((value) {
          mensagem("Tarefa ${value.titulo} Editada!");
        });
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _tarefaService = Provider.of<TarefaService>(context);
    _usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tarefa do ${_usuarioService.getNome()}")),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 40,),
            Text("${widget.acao}", style: TextStyle(fontSize: 20, letterSpacing: 5), textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: true,
                focusNode: this._focusTitulo,
                initialValue: (tarefa.titulo==null) ? "" : tarefa.titulo,
                validator: (titulo) {
                  if (titulo.isEmpty) {
                    return "Informe o título";
                  }
                  return null;
                },
                onFieldSubmitted: (titulo) {
                  this._focusTitulo.unfocus();
                  this._focusDescricao.requestFocus();
                },
                onSaved: (titulo) {
                  this._titulo = titulo;
                },
                decoration: InputDecoration(hintText: "Insira o título...", labelText: "Título", icon: Icon(Icons.border_color)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.text,
                focusNode: _focusDescricao,
                textInputAction: TextInputAction.next,
                maxLength: 100,
                initialValue: (tarefa.descricao==null) ? "" : tarefa.descricao,
                validator: (descricao) {
                  if (descricao.isEmpty) {
                    return "Informe a descrição";
                  }
                  return null;
                },
                onFieldSubmitted: (nome) {
                  this._focusDescricao.unfocus();
                  this._focusPrazo.requestFocus();
                },
                onSaved: (descricao) {
                  this._descricao = descricao;
                },
                decoration: InputDecoration(hintText: "Insira a descrição...", labelText: "Descrição", icon: Icon(Icons.text_fields)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: DateTimeFormField(
                  inputType: Type.date,
                  format: DateFormat("dd/MM/yyyy"),
                  textInputAction: TextInputAction.next,
                  focusNode: _focusPrazo,
                  initialValue: (tarefa.prazo==null) ? DateTime.now() : tarefa.prazo,
                  validator: (prazo) {
                    if (prazo == null) {
                      return "Informe o prazo. Não pode ser no passado.";
                    }
                    return null;
                  },
                  onFieldSubmitted: (prazo) {
                    this._focusPrazo.unfocus();
                  },
                  onSaved: (prazo) {
                    this._prazo = prazo;
                  },
                  inputDecoration: InputDecoration(hintText: "Informe o prazo...", labelText: "Prazo")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 103),
              child: RaisedButton(
                child: Text("Salvar"),
                onPressed: () {
                  this._save();
                },
                color: Colors.indigoAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}