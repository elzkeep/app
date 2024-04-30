import 'package:common_control/common_control.dart';


  
class Calendarcompanylist { 
  int id;
  int company;
  String month;
  String day;
  int status;
  int count;
  String checkdate;
  bool checked;
  Map<String, dynamic> extra;  

  Calendarcompanylist({        
          this.id = 0,       
          this.company = 0,       
          this.month = '',       
          this.day = '',       
          this.status = 0,       
          this.count = 0,       
          this.checkdate = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Calendarcompanylist.fromJson(Map<String, dynamic> json) {
    return Calendarcompanylist(
        id: json['id'] as int,
        company: json['company'] as int,
        month: json['month'] as String,
        day: json['day'] as String,
        status: json['status'] as int,
        count: json['count'] as int,
        checkdate: json['checkdate'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'company': company,'month': month,'day': day,'status': status,'count': count,'checkdate': checkdate };

  Calendarcompanylist clone() {
    return Calendarcompanylist.fromJson(toJson());
  }
}

class CalendarcompanylistManager {
  static const baseUrl = '/api/calendarcompanylist';  

  static Future<List<Calendarcompanylist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Calendarcompanylist>.empty(growable: true);
    }

    return result['items']
        .map<Calendarcompanylist>((json) => Calendarcompanylist.fromJson(json))
        .toList();
  }

  static Future<Calendarcompanylist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Calendarcompanylist();
    }

    return Calendarcompanylist.fromJson(result['item']);
  }

  static Future<int> insert(Calendarcompanylist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Calendarcompanylist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Calendarcompanylist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
