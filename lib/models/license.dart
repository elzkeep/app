import 'package:common_control/common_control.dart';
import 'package:zkeep/models/licensecategory.dart';
import 'package:zkeep/models/licenselevel.dart';


  
class License { 
  int id;
  int user;
  String number;
  String takingdate;
  String educationdate;
  String educationinstitution;
  String specialeducationdate;
  String specialeducationinstitution;
  Licensecategory licensecategory = Licensecategory();
  Licenselevel licenselevel = Licenselevel();
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  License({        
          this.id = 0,       
          this.user = 0,       
          this.number = '',       
          this.takingdate = '',       
          this.educationdate = '',       
          this.educationinstitution = '',       
          this.specialeducationdate = '',       
          this.specialeducationinstitution = '',       
          Licensecategory? licensecategory,       
          Licenselevel? licenselevel,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) {
          if (licensecategory != null) {
              this.licensecategory = licensecategory;
          }
if (licenselevel != null) {
              this.licenselevel = licenselevel;
          }
    }
  

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
        id: json['id'] as int,
        user: json['user'] as int,
        number: json['number'] as String,
        takingdate: json['takingdate'] as String,
        educationdate: json['educationdate'] as String,
        educationinstitution: json['educationinstitution'] as String,
        specialeducationdate: json['specialeducationdate'] as String,
        specialeducationinstitution: json['specialeducationinstitution'] as String,
        licensecategory: Licensecategory.fromJson(json['extra']['licensecategory']),
        licenselevel: Licenselevel.fromJson(json['extra']['licenselevel']),
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'user': user,'number': number,'takingdate': takingdate,'educationdate': educationdate,'educationinstitution': educationinstitution,'specialeducationdate': specialeducationdate,'specialeducationinstitution': specialeducationinstitution,'licensecategory': licensecategory.id,'licenselevel': licenselevel.id,'date': date };

  License clone() {
    return License.fromJson(toJson());
  }
}

class LicenseManager {
  static const baseUrl = '/api/license';  

  static Future<List<License>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<License>.empty(growable: true);
    }

    return result['items']
        .map<License>((json) => License.fromJson(json))
        .toList();
  }

  static Future<License> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return License();
    }

    return License.fromJson(result['item']);
  }

  static Future<int> insert(License item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(License item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(License item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
