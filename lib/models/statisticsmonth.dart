import 'package:common_control/common_control.dart';


  
class Statisticsmonth { 
  int id;
  String year;
  String duration;
  int total;
  int totalprice;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Statisticsmonth({        
          this.id = 0,       
          this.year = '',       
          this.duration = '',       
          this.total = 0,       
          this.totalprice = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Statisticsmonth.fromJson(Map<String, dynamic> json) {
    return Statisticsmonth(
        id: json['id'] as int,
        year: json['year'] as String,
        duration: json['duration'] as String,
        total: json['total'] as int,
        totalprice: json['totalprice'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'year': year,'duration': duration,'total': total,'totalprice': totalprice,'date': date };

  Statisticsmonth clone() {
    return Statisticsmonth.fromJson(toJson());
  }
}

class StatisticsmonthManager {
  static const baseUrl = '/api/statisticsmonth';  

  static Future<List<Statisticsmonth>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Statisticsmonth>.empty(growable: true);
    }

    return result['items']
        .map<Statisticsmonth>((json) => Statisticsmonth.fromJson(json))
        .toList();
  }

  static Future<Statisticsmonth> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Statisticsmonth();
    }

    return Statisticsmonth.fromJson(result['item']);
  }

  static Future<int> insert(Statisticsmonth item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Statisticsmonth item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Statisticsmonth item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
