import 'package:common_control/common_control.dart';


enum DataType {
    none, single, multi
}
  
class Data { 
  int id;
  String title;
  DataType type;
  int category;
  int order;
  int report;
  int company;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Data({        
          this.id = 0,       
          this.title = '',       
          this.type = DataType.none,       
          this.category = 0,       
          this.order = 0,       
          this.report = 0,       
          this.company = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'] as int,
        title: json['title'] as String,
        type: DataType.values[json['type'] as int],
        category: json['category'] as int,
        order: json['order'] as int,
        report: json['report'] as int,
        company: json['company'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'type': type.index,'category': category,'order': order,'report': report,'company': company,'date': date };

  Data clone() {
    return Data.fromJson(toJson());
  }
}

class DataManager {
  static const baseUrl = '/api/data';  

  static Future<List<Data>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Data>.empty(growable: true);
    }

    return result['items']
        .map<Data>((json) => Data.fromJson(json))
        .toList();
  }

  static Future<Data> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Data();
    }

    return Data.fromJson(result['item']);
  }

  static Future<int> insert(Data item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Data item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Data item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
