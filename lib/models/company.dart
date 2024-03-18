import 'package:common_control/common_control.dart';


enum CompanyType {
    none, work, building
}
  
class Company { 
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  CompanyType type;
  String billingname;
  String billingtel;
  String billingemail;
  int status;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Company({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.type = CompanyType.none,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.status = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        type: CompanyType.values[json['type'] as int],
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        status: json['status'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'type': type.index,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'status': status,'date': date };

  Company clone() {
    return Company.fromJson(toJson());
  }
}

class CompanyManager {
  static const baseUrl = '/api/company';  

  static Future<List<Company>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Company>.empty(growable: true);
    }

    return result['items']
        .map<Company>((json) => Company.fromJson(json))
        .toList();
  }

  static Future<Company> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Company();
    }

    return Company.fromJson(result['item']);
  }

  static Future<int> insert(Company item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Company item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Company item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
