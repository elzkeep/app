import 'package:common_control/common_control.dart';


  
class Companylicensecategory { 
  int id;
  String name;
  int order;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Companylicensecategory({        
          this.id = 0,       
          this.name = '',       
          this.order = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Companylicensecategory.fromJson(Map<String, dynamic> json) {
    return Companylicensecategory(
        id: json['id'] as int,
        name: json['name'] as String,
        order: json['order'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'order': order,'date': date };

  Companylicensecategory clone() {
    return Companylicensecategory.fromJson(toJson());
  }
}

class CompanylicensecategoryManager {
  static const baseUrl = '/api/companylicensecategory';  

  static Future<List<Companylicensecategory>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Companylicensecategory>.empty(growable: true);
    }

    return result['items']
        .map<Companylicensecategory>((json) => Companylicensecategory.fromJson(json))
        .toList();
  }

  static Future<Companylicensecategory> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Companylicensecategory();
    }

    return Companylicensecategory.fromJson(result['item']);
  }

  static Future<int> insert(Companylicensecategory item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Companylicensecategory item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Companylicensecategory item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
