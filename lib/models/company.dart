import 'package:common_control/common_control.dart';


enum CompanyType {
    none, work, building
}
  
class Company { 
  int id;
  String name;
  String companyno;
  String ceo;
  String tel;
  String email;
  String address;
  String addressetc;
  CompanyType type;
  String billingname;
  String billingtel;
  String billingemail;
  String bankname;
  String bankno;
  String businesscondition;
  String businessitem;
  String giro;
  String content;
  double x1;
  double y1;
  double x2;
  double y2;
  double x3;
  double y3;
  double x4;
  double y4;
  double x5;
  double y5;
  double x6;
  double y6;
  double x7;
  double y7;
  double x8;
  double y8;
  double x9;
  double y9;
  double x10;
  double y10;
  double x11;
  double y11;
  double x12;
  double y12;
  double x13;
  double y13;
  int status;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Company({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.tel = '',       
          this.email = '',       
          this.address = '',       
          this.addressetc = '',       
          this.type = CompanyType.none,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.bankname = '',       
          this.bankno = '',       
          this.businesscondition = '',       
          this.businessitem = '',       
          this.giro = '',       
          this.content = '',       
          this.x1 = 0.0,       
          this.y1 = 0.0,       
          this.x2 = 0.0,       
          this.y2 = 0.0,       
          this.x3 = 0.0,       
          this.y3 = 0.0,       
          this.x4 = 0.0,       
          this.y4 = 0.0,       
          this.x5 = 0.0,       
          this.y5 = 0.0,       
          this.x6 = 0.0,       
          this.y6 = 0.0,       
          this.x7 = 0.0,       
          this.y7 = 0.0,       
          this.x8 = 0.0,       
          this.y8 = 0.0,       
          this.x9 = 0.0,       
          this.y9 = 0.0,       
          this.x10 = 0.0,       
          this.y10 = 0.0,       
          this.x11 = 0.0,       
          this.y11 = 0.0,       
          this.x12 = 0.0,       
          this.y12 = 0.0,       
          this.x13 = 0.0,       
          this.y13 = 0.0,       
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
        tel: json['tel'] as String,
        email: json['email'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        type: CompanyType.values[json['type'] as int],
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        bankname: json['bankname'] as String,
        bankno: json['bankno'] as String,
        businesscondition: json['businesscondition'] as String,
        businessitem: json['businessitem'] as String,
        giro: json['giro'] as String,
        content: json['content'] as String,
        x1: json['x1'] as double,
        y1: json['y1'] as double,
        x2: json['x2'] as double,
        y2: json['y2'] as double,
        x3: json['x3'] as double,
        y3: json['y3'] as double,
        x4: json['x4'] as double,
        y4: json['y4'] as double,
        x5: json['x5'] as double,
        y5: json['y5'] as double,
        x6: json['x6'] as double,
        y6: json['y6'] as double,
        x7: json['x7'] as double,
        y7: json['y7'] as double,
        x8: json['x8'] as double,
        y8: json['y8'] as double,
        x9: json['x9'] as double,
        y9: json['y9'] as double,
        x10: json['x10'] as double,
        y10: json['y10'] as double,
        x11: json['x11'] as double,
        y11: json['y11'] as double,
        x12: json['x12'] as double,
        y12: json['y12'] as double,
        x13: json['x13'] as double,
        y13: json['y13'] as double,
        status: json['status'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'tel': tel,'email': email,'address': address,'addressetc': addressetc,'type': type.index,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'bankname': bankname,'bankno': bankno,'businesscondition': businesscondition,'businessitem': businessitem,'giro': giro,'content': content,'x1': x1,'y1': y1,'x2': x2,'y2': y2,'x3': x3,'y3': y3,'x4': x4,'y4': y4,'x5': x5,'y5': y5,'x6': x6,'y6': y6,'x7': x7,'y7': y7,'x8': x8,'y8': y8,'x9': x9,'y9': y9,'x10': x10,'y10': y10,'x11': x11,'y11': y11,'x12': x12,'y12': y12,'x13': x13,'y13': y13,'status': status,'date': date };

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
