class Item {
  String title;
  bool done;
  DateTime dataInicio;
  DateTime dataFim;

  Item({this.title, this.done, this.dataInicio, this.dataFim});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
    dataInicio = DateTime.tryParse(json['dataInicio']);
    dataFim = DateTime.tryParse(json['dataFim']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    data['dataInicio'] = this.dataInicio.toIso8601String();
    data['dataFim'] = this.dataFim.toIso8601String();
    return data;
  }
}