import 'package:common_control/common_control.dart';


  
class License { 
  int id;
  int user;
  int licensecategory;
  int licenselevel;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  License({        
          this.id = 0,       
          this.user = 0,       
          this.licensecategory = 0,       
          this.licenselevel = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
        id: json['id'] as int,
        user: json['user'] as int,
        licensecategory: json['licensecategory'] as int,
        licenselevel: json['licenselevel'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'user': user,'licensecategory': licensecategory,'licenselevel': licenselevel,'date': date };

  License clone() {
    return License.fromJson(toJson());
  }
}

class LicenseManager {
  static const baseUrl = '/api/license';  

  static Future<List<License>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<License>.empty(growable: true);
    }

    return result['items']
        .map<License>((json) => License.fromJson(json))
        .toList();
  }

  static Future<License> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return License();
    }

    return License.fromJson(result['item']);
  }

  static Future<int> insert(License item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(License item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(License item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
