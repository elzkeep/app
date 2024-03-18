import 'package:common_control/common_control.dart';


  
class Customercompany { 
  int company;
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  int type;
  int status;
  String billingname;
  String billingtel;
  String billingemail;
  String date;
  int buildingcount;
  int contractprice;
  double score;
  bool checked;
  Map<String, dynamic> extra;  

  Customercompany({        
          this.company = 0,       
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.type = 0,       
          this.status = 0,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.date = '',       
          this.buildingcount = 0,       
          this.contractprice = 0,       
          this.score = 0.0,
          this.extra = const{},
          this.checked = false}) ;
  

  factory Customercompany.fromJson(Map<String, dynamic> json) {
    return Customercompany(
        company: json['company'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        type: json['type'] as int,
        status: json['status'] as int,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        date: json['date'] as String,
        buildingcount: json['buildingcount'] as int,
        contractprice: json['contractprice'] as int,
        score: json['score'] as double, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'company': company,'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'type': type,'status': status,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'date': date,'buildingcount': buildingcount,'contractprice': contractprice,'score': score };

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
