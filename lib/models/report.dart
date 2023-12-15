import 'package:common_control/common_control.dart';


  
class Report { 
  int id;
  String title;
  int status;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Report({        
          this.id = 0,       
          this.title = '',       
          this.status = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        id: json['id'] as int,
        title: json['title'] as String,
        status: json['status'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'status': status,'date': date };
}

class ReportManager {
  static const baseUrl = '/api/report';  

  static Future<List<Report>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Report>.empty(growable: true);
    }

    return result['items']
        .map<Report>((json) => Report.fromJson(json))
        .toList();
  }

  static Future<Report> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Report();
    }

    return Report.fromJson(result['item']);
  }

  static Future<int> insert(Report item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Report item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Report item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
