import 'package:common_control/common_control.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/item.dart';

class Dataitem {
  int report;
  int order;
  Data data;
  String parent;
  List<Item> items;

  Dataitem(
      {this.report = 0,
      this.order = 0,
      required this.data,
      required this.items,
      this.parent = ''});

  factory Dataitem.empty() {
    return Dataitem(report: 0, order: 0, data: Data(), parent: '', items: []);
  }

  factory Dataitem.fromJson(Map<String, dynamic> json) {
    List<Item> items = [];

    var item = json['items'] as List<dynamic>;
    for (var i = 0; i < item.length; i++) {
      items.add(Item.fromJson(item[i]));
    }

    return Dataitem(
        report: json['report'] as int,
        order: json['order'] as int,
        parent: json['parent'] as String,
        data: Data.fromJson(json['data']),
        items: items);
  }

  Map<String, dynamic> toJson() =>
      {'report': report, 'order': order, 'data': data, 'parent': parent, 'items': items};

  Dataitem clone() {
    return Dataitem.fromJson(toJson());
  }
}

class DataitemManager {
  static const baseUrl = '/api/dataitem';

  static insert(List<Dataitem> datas) async {
    List<Map<String, dynamic>> items = [];

    for (var i = 0; i < datas.length; i++) {
      final data = datas[i];
      items.add(data.toJson());

      //print(data.toJson());
    }

    await Http.post('$baseUrl/process', items);
    print('gogo2');
  }
}
