import 'package:common_control/common_control.dart';


  
class Reportlist { 
  int id;
  String title;
  int period;
  int number;
  String checkdate;
  String checktime;
  String content;
  String image;
  String sign1;
  String sign2;
  int status;
  int company;
  int user;
  int building;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Reportlist({        
          this.id = 0,       
          this.title = '',       
          this.period = 0,       
          this.number = 0,       
          this.checkdate = '',       
          this.checktime = '',       
          this.content = '',       
          this.image = '',       
          this.sign1 = '',       
          this.sign2 = '',       
          this.status = 0,       
          this.company = 0,       
          this.user = 0,       
          this.building = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Reportlist.fromJson(Map<String, dynamic> json) {
    return Reportlist(
        id: json['id'] as int,
        title: json['title'] as String,
        period: json['period'] as int,
        number: json['number'] as int,
        checkdate: json['checkdate'] as String,
        checktime: json['checktime'] as String,
        content: json['content'] as String,
        image: json['image'] as String,
        sign1: json['sign1'] as String,
        sign2: json['sign2'] as String,
        status: json['status'] as int,
        company: json['company'] as int,
        user: json['user'] as int,
        building: json['building'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'period': period,'number': number,'checkdate': checkdate,'checktime': checktime,'content': content,'image': image,'sign1': sign1,'sign2': sign2,'status': status,'company': company,'user': user,'building': building,'date': date };

  Reportlist clone() {
    return Reportlist.fromJson(toJson());
  }
}

class ReportlistManager {
  static const baseUrl = '/api/reportlist';  

  static Future<List<Reportlist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Reportlist>.empty(growable: true);
    }

    return result['items']
        .map<Reportlist>((json) => Reportlist.fromJson(json))
        .toList();
  }

  static Future<Reportlist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Reportlist();
    }

    return Reportlist.fromJson(result['item']);
  }

  static Future<int> insert(Reportlist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Reportlist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Reportlist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
