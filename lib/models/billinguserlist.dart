import 'package:common_control/common_control.dart';


  
class Billinguserlist { 
  int id;
  int price;
  int status;
  int giro;
  String billdate;
  String month;
  int period;
  int company;
  int building;
  String date;
  String buildingname;
  String billingname;
  String billingtel;
  String billingemail;
  int user;
  String username;
  bool checked;
  Map<String, dynamic> extra;  

  Billinguserlist({        
          this.id = 0,       
          this.price = 0,       
          this.status = 0,       
          this.giro = 0,       
          this.billdate = '',       
          this.month = '',       
          this.period = 0,       
          this.company = 0,       
          this.building = 0,       
          this.date = '',       
          this.buildingname = '',       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.user = 0,       
          this.username = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Billinguserlist.fromJson(Map<String, dynamic> json) {
    return Billinguserlist(
        id: json['id'] as int,
        price: json['price'] as int,
        status: json['status'] as int,
        giro: json['giro'] as int,
        billdate: json['billdate'] as String,
        month: json['month'] as String,
        period: json['period'] as int,
        company: json['company'] as int,
        building: json['building'] as int,
        date: json['date'] as String,
        buildingname: json['buildingname'] as String,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        user: json['user'] as int,
        username: json['username'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'price': price,'status': status,'giro': giro,'billdate': billdate,'month': month,'period': period,'company': company,'building': building,'date': date,'buildingname': buildingname,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'user': user,'username': username };

  Billinguserlist clone() {
    return Billinguserlist.fromJson(toJson());
  }
}

class BillinguserlistManager {
  static const baseUrl = '/api/billinguserlist';  

  static Future<List<Billinguserlist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Billinguserlist>.empty(growable: true);
    }

    return result['items']
        .map<Billinguserlist>((json) => Billinguserlist.fromJson(json))
        .toList();
  }

  static Future<Billinguserlist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Billinguserlist();
    }

    return Billinguserlist.fromJson(result['item']);
  }

  static Future<int> insert(Billinguserlist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Billinguserlist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Billinguserlist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
