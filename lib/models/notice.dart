import 'package:common_control/common_control.dart';


  
class Notice { 
  int id;
  String title;
  String content;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Notice({        
          this.id = 0,       
          this.title = '',       
          this.content = '',       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'content': content,'date': date };

  Notice clone() {
    return Notice.fromJson(toJson());
  }
}

class NoticeManager {
  static const baseUrl = '/api/notice';  

  static Future<List<Notice>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Notice>.empty(growable: true);
    }

    return result['items']
        .map<Notice>((json) => Notice.fromJson(json))
        .toList();
  }

  static Future<Notice> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Notice();
    }

    return Notice.fromJson(result['item']);
  }

  static Future<int> insert(Notice item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Notice item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Notice item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
