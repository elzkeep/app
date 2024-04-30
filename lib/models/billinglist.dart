import 'package:common_control/common_control.dart';


enum BillinglistStatus {
    none, wait, complete
}
enum BillinglistGiro {
    none, wait, complete
}
  
class Billinglist { 
  int id;
  int price;
  BillinglistStatus status;
  BillinglistGiro giro;
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
  bool checked;
  Map<String, dynamic> extra;  

  Billinglist({        
          this.id = 0,       
          this.price = 0,       
          this.status = BillinglistStatus.none,       
          this.giro = BillinglistGiro.none,       
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
          this.extra = const{},
          this.checked = false}) ;
  

  factory Billinglist.fromJson(Map<String, dynamic> json) {
    return Billinglist(
        id: json['id'] as int,
        price: json['price'] as int,
        status: BillinglistStatus.values[json['status'] as int],
        giro: BillinglistGiro.values[json['giro'] as int],
        billdate: json['billdate'] as String,
        month: json['month'] as String,
        period: json['period'] as int,
        company: json['company'] as int,
        building: json['building'] as int,
        date: json['date'] as String,
        buildingname: json['buildingname'] as String,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'price': price,'status': status.index,'giro': giro.index,'billdate': billdate,'month': month,'period': period,'company': company,'building': building,'date': date,'buildingname': buildingname,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail };

  Billinglist clone() {
    return Billinglist.fromJson(toJson());
  }
}

class BillinglistManager {
  static const baseUrl = '/api/billinglist';  

  static Future<List<Billinglist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Billinglist>.empty(growable: true);
    }

    return result['items']
        .map<Billinglist>((json) => Billinglist.fromJson(json))
        .toList();
  }

  static Future<Billinglist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Billinglist();
    }

    return Billinglist.fromJson(result['item']);
  }

  static Future<int> insert(Billinglist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Billinglist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Billinglist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
