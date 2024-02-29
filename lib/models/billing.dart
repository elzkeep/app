import 'package:common_control/common_control.dart';
import 'package:zkeep/models/building.dart';


enum BillingStatus {
    none, wait, complete
}
enum BillingGiro {
    none, wait, complete
}
  
class Billing { 
  int id;
  int price;
  BillingStatus status;
  BillingGiro giro;
  String billdate;
  int company;
  Building building = Building();
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Billing({        
          this.id = 0,       
          this.price = 0,       
          this.status = BillingStatus.none,       
          this.giro = BillingGiro.none,       
          this.billdate = '',       
          this.company = 0,       
          Building? building,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) {
          if (building != null) {
              this.building = building;
          }
    }
  

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
        id: json['id'] as int,
        price: json['price'] as int,
        status: BillingStatus.values[json['status'] as int],
        giro: BillingGiro.values[json['giro'] as int],
        billdate: json['billdate'] as String,
        company: json['company'] as int,
        building: Building.fromJson(json['extra']['building']),
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'price': price,'status': status.index,'giro': giro.index,'billdate': billdate,'company': company,'building': building.id,'date': date };

  Billing clone() {
    return Billing.fromJson(toJson());
  }
}

class BillingManager {
  static const baseUrl = '/api/billing';  

  static Future<List<Billing>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Billing>.empty(growable: true);
    }

    return result['items']
        .map<Billing>((json) => Billing.fromJson(json))
        .toList();
  }

  static Future<Billing> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Billing();
    }

    return Billing.fromJson(result['item']);
  }

  static Future<int> insert(Billing item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Billing item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Billing item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
