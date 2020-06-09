import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/item.dart';
import 'package:todo/widgets/form/date_time_form.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'MetasApp',
      theme: ThemeData(brightness: Brightness.dark),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  var items = List<Item>();
  var nomeLista;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var controlador = TextEditingController();
  var df = DateFormat("dd/MM/yy");

  _HomePageState() {
    loadJson();
  }

  Future loadJson() async {
    print("Loading Json...");
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    var nomeLista = prefs.getString('nomeLista');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> items = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = items;
        controlador.text = nomeLista;
      });
    }
  }

  Future saveJson() async {
    print("Saving Json...");
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  Future saveNameLista() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('nomeLista', controlador.text);
  }

  saveItem(novoItem) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        widget.items.add(novoItem);
        saveJson();
      });
      Navigator.of(context).pop();
    }
  }

  addDialog(BuildContext context) {
    var novoItem = Item();
    novoItem.done = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.format_list_numbered),
                Text("  Nova tarefa"),
              ],
            ),
            content: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (nome) =>
                          nome == null ? "Informe o nome" : null,
                      onSaved: (title) {
                        novoItem.title = title;
                      },
                      decoration: InputDecoration(
                          hintText: "Nome da tarefa", icon: Icon(Icons.title)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: DateTimeFormField(
                        inputType: Type.date,
                        format: DateFormat("dd/MM/yy"),
                        textInputAction: TextInputAction.next,
                        validator: (dataInicio) => dataInicio == null
                            ? "Informe a Data Inícial"
                            : null,
                        onSaved: (dataInicio) {
                          novoItem.dataInicio = dataInicio;
                        },
                        inputDecoration:
                            InputDecoration(hintText: "Data Inícial")),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: DateTimeFormField(
                        inputType: Type.date,
                        format: DateFormat("dd/MM/yy"),
                        textInputAction: TextInputAction.next,
                        validator: (dataFim) =>
                            dataFim == null ? "Informe a Data Final" : null,
                        onSaved: (dataFim) {
                          novoItem.dataFim = dataFim;
                        },
                        inputDecoration:
                            InputDecoration(hintText: "Data final")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 10, right: 10, bottom: 5),
                    child: RaisedButton(
                      child: Text("Criar"),
                      onPressed: () {
                        this.saveItem(novoItem);
                      },
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.deepPurple,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: TextFormField(
          controller: controlador,
          keyboardType: TextInputType.text,
          initialValue: widget.nomeLista,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(hintText: "Nome da lista", enabledBorder: InputBorder.none),
          onChanged: (value){
            saveNameLista();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];
          return CheckboxListTile(
            activeColor: Colors.deepPurpleAccent[100],
            checkColor: Colors.deepPurple,
            secondary: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  widget.items.removeAt(index);
                  saveJson();
                });
              },
            ),
            subtitle: Text(df.format(item.dataInicio).toString() +
                " - " +
                df.format(item.dataFim).toString()),
            title: Text(item.title),
            key: Key(item.title),
            value: item.done,
            onChanged: (value) {
              setState(() {
                item.done = value;
                saveJson();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addDialog(context);
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent[100],
        foregroundColor: Colors.white,
      ),
    );
  }
}
