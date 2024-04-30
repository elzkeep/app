import 'package:common_control/common_control.dart';


  
class Companylicense { 
  int id;
  String number;
  String takingdate;
  String educationdate;
  String educationinstitution;
  String specialeducationdate;
  String specialeducationinstitution;
  int company;
  int licensecategory;
  int licenselevel;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Companylicense({        
          this.id = 0,       
          this.number = '',       
          this.takingdate = '',       
          this.educationdate = '',       
          this.educationinstitution = '',       
          this.specialeducationdate = '',       
          this.specialeducationinstitution = '',       
          this.company = 0,       
          this.licensecategory = 0,       
          this.licenselevel = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Companylicense.fromJson(Map<String, dynamic> json) {
    return Companylicense(
        id: json['id'] as int,
        number: json['number'] as String,
        takingdate: json['takingdate'] as String,
        educationdate: json['educationdate'] as String,
        educationinstitution: json['educationinstitution'] as String,
        specialeducationdate: json['specialeducationdate'] as String,
        specialeducationinstitution: json['specialeducationinstitution'] as String,
        company: json['company'] as int,
        licensecategory: json['licensecategory'] as int,
        licenselevel: json['licenselevel'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'number': number,'takingdate': takingdate,'educationdate': educationdate,'educationinstitution': educationinstitution,'specialeducationdate': specialeducationdate,'specialeducationinstitution': specialeducationinstitution,'company': company,'licensecategory': licensecategory,'licenselevel': licenselevel,'date': date };

  Companylicense clone() {
    return Companylicense.fromJson(toJson());
  }
}

class CompanylicenseManager {
  static const baseUrl = '/api/companylicense';  

  static Future<List<Companylicense>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Companylicense>.empty(growable: true);
    }

    return result['items']
        .map<Companylicense>((json) => Companylicense.fromJson(json))
        .toList();
  }

  static Future<Companylicense> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Companylicense();
    }

    return Companylicense.fromJson(result['item']);
  }

  static Future<int> insert(Companylicense item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Companylicense item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Companylicense item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
