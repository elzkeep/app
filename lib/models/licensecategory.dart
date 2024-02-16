import 'package:common_control/common_control.dart';


  
class Licensecategory { 
  int id;
  String name;
  int order;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Licensecategory({        
          this.id = 0,       
          this.name = '',       
          this.order = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Licensecategory.fromJson(Map<String, dynamic> json) {
    return Licensecategory(
        id: json['id'] as int,
        name: json['name'] as String,
        order: json['order'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'order': order,'date': date };

  Licensecategory clone() {
    return Licensecategory.fromJson(toJson());
  }
}

class LicensecategoryManager {
  static const baseUrl = '/api/licensecategory';  

  static Future<List<Licensecategory>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Licensecategory>.empty(growable: true);
    }

    return result['items']
        .map<Licensecategory>((json) => Licensecategory.fromJson(json))
        .toList();
  }

  static Future<Licensecategory> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Licensecategory();
    }

    return Licensecategory.fromJson(result['item']);
  }

  static Future<int> insert(Licensecategory item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Licensecategory item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Licensecategory item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
