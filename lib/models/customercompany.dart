import 'package:common_control/common_control.dart';


  
class Customercompany { 
  int id;
  int company;
  int customer;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Customercompany({        
          this.id = 0,       
          this.company = 0,       
          this.customer = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Customercompany.fromJson(Map<String, dynamic> json) {
    return Customercompany(
        id: json['id'] as int,
        company: json['company'] as int,
        customer: json['customer'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'company': company,'customer': customer,'date': date };

  Customercompany clone() {
    return Customercompany.fromJson(toJson());
  }
}

class CustomercompanyManager {
  static const baseUrl = '/api/customercompany';  

  static Future<List<Customercompany>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Customercompany>.empty(growable: true);
    }

    return result['items']
        .map<Customercompany>((json) => Customercompany.fromJson(json))
        .toList();
  }

  static Future<Customercompany> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Customercompany();
    }

    return Customercompany.fromJson(result['item']);
  }

  static Future<int> insert(Customercompany item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Customercompany item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Customercompany item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
