import 'package:common_control/common_control.dart';


  
class Companygroup { 
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Companygroup({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Companygroup.fromJson(Map<String, dynamic> json) {
    return Companygroup(
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'date': date };

  Companygroup clone() {
    return Companygroup.fromJson(toJson());
  }
}

class CompanygroupManager {
  static const baseUrl = '/api/companygroup';  

  static Future<List<Companygroup>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Companygroup>.empty(growable: true);
    }

    return result['items']
        .map<Companygroup>((json) => Companygroup.fromJson(json))
        .toList();
  }

  static Future<Companygroup> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Companygroup();
    }

    return Companygroup.fromJson(result['item']);
  }

  static Future<int> insert(Companygroup item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Companygroup item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Companygroup item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
