import 'package:common_control/common_control.dart';


  
class Customercompanylist { 
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  String tel;
  String email;
  String date;
  int company;
  int buildingcount;
  bool checked;
  Map<String, dynamic> extra;  

  Customercompanylist({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.tel = '',       
          this.email = '',       
          this.date = '',       
          this.company = 0,       
          this.buildingcount = 0,
          this.extra = const{},
          this.checked = false}) ;
  

  factory Customercompanylist.fromJson(Map<String, dynamic> json) {
    return Customercompanylist(
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        tel: json['tel'] as String,
        email: json['email'] as String,
        date: json['date'] as String,
        company: json['company'] as int,
        buildingcount: json['buildingcount'] as int, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'tel': tel,'email': email,'date': date,'company': company,'buildingcount': buildingcount };

  Customercompanylist clone() {
    return Customercompanylist.fromJson(toJson());
  }
}

class CustomercompanylistManager {
  static const baseUrl = '/api/customercompanylist';  

  static Future<List<Customercompanylist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Customercompanylist>.empty(growable: true);
    }

    return result['items']
        .map<Customercompanylist>((json) => Customercompanylist.fromJson(json))
        .toList();
  }

  static Future<Customercompanylist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Customercompanylist();
    }

    return Customercompanylist.fromJson(result['item']);
  }

  static Future<int> insert(Customercompanylist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Customercompanylist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Customercompanylist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
