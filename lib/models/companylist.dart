import 'package:common_control/common_control.dart';


  
class Companylist { 
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
  int contractprice;
  bool checked;
  Map<String, dynamic> extra;  

  Companylist({        
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
          this.contractprice = 0,
          this.extra = const{},
          this.checked = false}) ;
  

  factory Companylist.fromJson(Map<String, dynamic> json) {
    return Companylist(
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
        buildingcount: json['buildingcount'] as int,
        contractprice: json['contractprice'] as int, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'tel': tel,'email': email,'date': date,'company': company,'buildingcount': buildingcount,'contractprice': contractprice };

  Companylist clone() {
    return Companylist.fromJson(toJson());
  }
}

class CompanylistManager {
  static const baseUrl = '/api/companylist';  

  static Future<List<Companylist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Companylist>.empty(growable: true);
    }

    return result['items']
        .map<Companylist>((json) => Companylist.fromJson(json))
        .toList();
  }

  static Future<Companylist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Companylist();
    }

    return Companylist.fromJson(result['item']);
  }

  static Future<int> insert(Companylist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Companylist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Companylist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
