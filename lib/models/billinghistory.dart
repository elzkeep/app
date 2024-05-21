import 'package:common_control/common_control.dart';


  
class Billinghistory { 
  int id;
  int price;
  int company;
  int building;
  int billing;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Billinghistory({        
          this.id = 0,       
          this.price = 0,       
          this.company = 0,       
          this.building = 0,       
          this.billing = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Billinghistory.fromJson(Map<String, dynamic> json) {
    return Billinghistory(
        id: json['id'] as int,
        price: json['price'] as int,
        company: json['company'] as int,
        building: json['building'] as int,
        billing: json['billing'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'price': price,'company': company,'building': building,'billing': billing,'date': date };

  Billinghistory clone() {
    return Billinghistory.fromJson(toJson());
  }
}

class BillinghistoryManager {
  static const baseUrl = '/api/billinghistory';  

  static Future<List<Billinghistory>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Billinghistory>.empty(growable: true);
    }

    return result['items']
        .map<Billinghistory>((json) => Billinghistory.fromJson(json))
        .toList();
  }

  static Future<Billinghistory> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Billinghistory();
    }

    return Billinghistory.fromJson(result['item']);
  }

  static Future<int> insert(Billinghistory item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Billinghistory item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Billinghistory item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
