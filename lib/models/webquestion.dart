import 'package:common_control/common_control.dart';


  
class Webquestion { 
  int id;
  String email;
  String tel;
  String content;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Webquestion({        
          this.id = 0,       
          this.email = '',       
          this.tel = '',       
          this.content = '',       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Webquestion.fromJson(Map<String, dynamic> json) {
    return Webquestion(
        id: json['id'] as int,
        email: json['email'] as String,
        tel: json['tel'] as String,
        content: json['content'] as String,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'email': email,'tel': tel,'content': content,'date': date };

  Webquestion clone() {
    return Webquestion.fromJson(toJson());
  }
}

class WebquestionManager {
  static const baseUrl = '/api/webquestion';  

  static Future<List<Webquestion>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Webquestion>.empty(growable: true);
    }

    return result['items']
        .map<Webquestion>((json) => Webquestion.fromJson(json))
        .toList();
  }

  static Future<Webquestion> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Webquestion();
    }

    return Webquestion.fromJson(result['item']);
  }

  static Future<int> insert(Webquestion item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Webquestion item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Webquestion item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
