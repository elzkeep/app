import 'package:common_control/common_control.dart';


  
class Building { 
  int id;
  String name;
  String conpanyno;
  String ceo;
  String address;
  String addressetc;
  int status;
  int company;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Building({        
          this.id = 0,       
          this.name = '',       
          this.conpanyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.status = 0,       
          this.company = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
        id: json['id'] as int,
        name: json['name'] as String,
        conpanyno: json['conpanyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        status: json['status'] as int,
        company: json['company'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'conpanyno': conpanyno,'ceo': ceo,'address': address,'addressetc': addressetc,'status': status,'company': company,'date': date };

  Building clone() {
    return Building.fromJson(toJson());
  }
}

class BuildingManager {
  static const baseUrl = '/api/building';  

  static Future<List<Building>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Building>.empty(growable: true);
    }

    return result['items']
        .map<Building>((json) => Building.fromJson(json))
        .toList();
  }

  static Future<Building> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Building();
    }

    return Building.fromJson(result['item']);
  }

  static Future<int> insert(Building item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Building item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Building item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
