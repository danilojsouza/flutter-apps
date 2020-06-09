import 'package:controle.tarefas/model/usuario.dart';

class Tarefa {
  int id;
  String titulo;
  String descricao;
  DateTime prazo;
  bool concluida;
  Usuario criador;

  Tarefa({this.id, this.titulo, this.concluida, this.prazo, this.descricao, this.criador});

  Tarefa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    prazo = DateTime.tryParse(json['prazo']);
    concluida = json['concluida'];
    criador = Usuario.fromJson(json['criador']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['prazo'] = this.prazo.toString();
    data['concluida'] = this.concluida;
    data['criador'] = this.criador;
    return data;
  }
}