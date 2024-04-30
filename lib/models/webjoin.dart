import 'package:common_control/common_control.dart';


  
class Webjoin { 
  int id;
  int category;
  String name;
  String manager;
  String tel;
  String email;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Webjoin({        
          this.id = 0,       
          this.category = 0,       
          this.name = '',       
          this.manager = '',       
          this.tel = '',       
          this.email = '',       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Webjoin.fromJson(Map<String, dynamic> json) {
    return Webjoin(
        id: json['id'] as int,
        category: json['category'] as int,
        name: json['name'] as String,
        manager: json['manager'] as String,
        tel: json['tel'] as String,
        email: json['email'] as String,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'category': category,'name': name,'manager': manager,'tel': tel,'email': email,'date': date };

  Webjoin clone() {
    return Webjoin.fromJson(toJson());
  }
}

class WebjoinManager {
  static const baseUrl = '/api/webjoin';  

  static Future<List<Webjoin>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Webjoin>.empty(growable: true);
    }

    return result['items']
        .map<Webjoin>((json) => Webjoin.fromJson(json))
        .toList();
  }

  static Future<Webjoin> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Webjoin();
    }

    return Webjoin.fromJson(result['item']);
  }

  static Future<int> insert(Webjoin item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Webjoin item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Webjoin item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
