import 'package:common_control/common_control.dart';


  
class Companylicense { 
  int id;
  int company;
  int licensecategory;
  int licenselevel;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Companylicense({        
          this.id = 0,       
          this.company = 0,       
          this.licensecategory = 0,       
          this.licenselevel = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Companylicense.fromJson(Map<String, dynamic> json) {
    return Companylicense(
        id: json['id'] as int,
        company: json['company'] as int,
        licensecategory: json['licensecategory'] as int,
        licenselevel: json['licenselevel'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'company': company,'licensecategory': licensecategory,'licenselevel': licenselevel,'date': date };

  Companylicense clone() {
    return Companylicense.fromJson(toJson());
  }
}

class CompanylicenseManager {
  static const baseUrl = '/api/companylicense';  

  static Future<List<Companylicense>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Companylicense>.empty(growable: true);
    }

    return result['items']
        .map<Companylicense>((json) => Companylicense.fromJson(json))
        .toList();
  }

  static Future<Companylicense> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Companylicense();
    }

    return Companylicense.fromJson(result['item']);
  }

  static Future<int> insert(Companylicense item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Companylicense item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Companylicense item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
