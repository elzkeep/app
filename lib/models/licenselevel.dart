import 'package:common_control/common_control.dart';


  
class Licenselevel { 
  int id;
  String name;
  int order;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Licenselevel({        
          this.id = 0,       
          this.name = '',       
          this.order = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Licenselevel.fromJson(Map<String, dynamic> json) {
    return Licenselevel(
        id: json['id'] as int,
        name: json['name'] as String,
        order: json['order'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'order': order,'date': date };

  Licenselevel clone() {
    return Licenselevel.fromJson(toJson());
  }
}

class LicenselevelManager {
  static const baseUrl = '/api/licenselevel';  

  static Future<List<Licenselevel>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Licenselevel>.empty(growable: true);
    }

    return result['items']
        .map<Licenselevel>((json) => Licenselevel.fromJson(json))
        .toList();
  }

  static Future<Licenselevel> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Licenselevel();
    }

    return Licenselevel.fromJson(result['item']);
  }

  static Future<int> insert(Licenselevel item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Licenselevel item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Licenselevel item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
