import 'package:common_control/common_control.dart';


  
class Statisticsyear { 
  int id;
  String duration;
  int total;
  int totalprice;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Statisticsyear({        
          this.id = 0,       
          this.duration = '',       
          this.total = 0,       
          this.totalprice = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Statisticsyear.fromJson(Map<String, dynamic> json) {
    return Statisticsyear(
        id: json['id'] as int,
        duration: json['duration'] as String,
        total: json['total'] as int,
        totalprice: json['totalprice'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'duration': duration,'total': total,'totalprice': totalprice,'date': date };

  Statisticsyear clone() {
    return Statisticsyear.fromJson(toJson());
  }
}

class StatisticsyearManager {
  static const baseUrl = '/api/statisticsyear';  

  static Future<List<Statisticsyear>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Statisticsyear>.empty(growable: true);
    }

    return result['items']
        .map<Statisticsyear>((json) => Statisticsyear.fromJson(json))
        .toList();
  }

  static Future<Statisticsyear> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Statisticsyear();
    }

    return Statisticsyear.fromJson(result['item']);
  }

  static Future<int> insert(Statisticsyear item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Statisticsyear item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Statisticsyear item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
