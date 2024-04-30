import 'package:common_control/common_control.dart';


  
class Webnotice { 
  int id;
  String title;
  String content;
  String image;
  int category;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Webnotice({        
          this.id = 0,       
          this.title = '',       
          this.content = '',       
          this.image = '',       
          this.category = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Webnotice.fromJson(Map<String, dynamic> json) {
    return Webnotice(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        image: json['image'] as String,
        category: json['category'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'content': content,'image': image,'category': category,'date': date };

  Webnotice clone() {
    return Webnotice.fromJson(toJson());
  }
}

class WebnoticeManager {
  static const baseUrl = '/api/webnotice';  

  static Future<List<Webnotice>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Webnotice>.empty(growable: true);
    }

    return result['items']
        .map<Webnotice>((json) => Webnotice.fromJson(json))
        .toList();
  }

  static Future<Webnotice> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Webnotice();
    }

    return Webnotice.fromJson(result['item']);
  }

  static Future<int> insert(Webnotice item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Webnotice item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Webnotice item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
