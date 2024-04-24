import 'package:common_control/common_control.dart';


  
class Building { 
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  double contractvolumn;
  double receivevolumn;
  double generatevolumn;
  double sunlightvolumn;
  int volttype;
  double weight;
  double totalweight;
  int checkcount;
  int receivevolt;
  int generatevolt;
  int periodic;
  String usage;
  String district;
  double score;
  int status;
  int company;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Building({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.contractvolumn = 0.0,       
          this.receivevolumn = 0.0,       
          this.generatevolumn = 0.0,       
          this.sunlightvolumn = 0.0,       
          this.volttype = 0,       
          this.weight = 0.0,       
          this.totalweight = 0.0,       
          this.checkcount = 0,       
          this.receivevolt = 0,       
          this.generatevolt = 0,       
          this.periodic = 0,       
          this.usage = '',       
          this.district = '',       
          this.score = 0.0,       
          this.status = 0,       
          this.company = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        contractvolumn: json['contractvolumn'] as double,
        receivevolumn: json['receivevolumn'] as double,
        generatevolumn: json['generatevolumn'] as double,
        sunlightvolumn: json['sunlightvolumn'] as double,
        volttype: json['volttype'] as int,
        weight: json['weight'] as double,
        totalweight: json['totalweight'] as double,
        checkcount: json['checkcount'] as int,
        receivevolt: json['receivevolt'] as int,
        generatevolt: json['generatevolt'] as int,
        periodic: json['periodic'] as int,
        usage: json['usage'] as String,
        district: json['district'] as String,
        score: json['score'] as double,
        status: json['status'] as int,
        company: json['company'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'contractvolumn': contractvolumn,'receivevolumn': receivevolumn,'generatevolumn': generatevolumn,'sunlightvolumn': sunlightvolumn,'volttype': volttype,'weight': weight,'totalweight': totalweight,'checkcount': checkcount,'receivevolt': receivevolt,'generatevolt': generatevolt,'periodic': periodic,'usage': usage,'district': district,'score': score,'status': status,'company': company,'date': date };

  Building clone() {
    return Building.fromJson(toJson());
  }
}

class BuildingManager {
  static const baseUrl = '/api/building';  

  static Future<List<Building>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Building>.empty(growable: true);
    }

    return result['items']
        .map<Building>((json) => Building.fromJson(json))
        .toList();
  }

  static Future<Building> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Building();
    }

    return Building.fromJson(result['item']);
  }

  static Future<int> insert(Building item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Building item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Building item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
