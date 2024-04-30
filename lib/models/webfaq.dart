import 'package:common_control/common_control.dart';


  
class Webfaq { 
  int id;
  int category;
  String title;
  String content;
  int order;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Webfaq({        
          this.id = 0,       
          this.category = 0,       
          this.title = '',       
          this.content = '',       
          this.order = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Webfaq.fromJson(Map<String, dynamic> json) {
    return Webfaq(
        id: json['id'] as int,
        category: json['category'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        order: json['order'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'category': category,'title': title,'content': content,'order': order,'date': date };

  Webfaq clone() {
    return Webfaq.fromJson(toJson());
  }
}

class WebfaqManager {
  static const baseUrl = '/api/webfaq';  

  static Future<List<Webfaq>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Webfaq>.empty(growable: true);
    }

    return result['items']
        .map<Webfaq>((json) => Webfaq.fromJson(json))
        .toList();
  }

  static Future<Webfaq> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Webfaq();
    }

    return Webfaq.fromJson(result['item']);
  }

  static Future<int> insert(Webfaq item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Webfaq item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Webfaq item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
