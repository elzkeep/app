import 'package:common_control/common_control.dart';


  
class Company { 
  int id;
  String name;
  String companyno;
  String ceo;
  String address;
  String addressetc;
  String buildingname;
  String buildingcompanyno;
  String buildingceo;
  String buildingaddress;
  String buildingaddressetc;
  int type;
  int checkdate;
  String managername;
  String managertel;
  String manageremail;
  String contractstartdate;
  String contractenddate;
  int contractprice;
  int billingdate;
  String billingname;
  String billingtel;
  String billingemail;
  int status;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Company({        
          this.id = 0,       
          this.name = '',       
          this.companyno = '',       
          this.ceo = '',       
          this.address = '',       
          this.addressetc = '',       
          this.buildingname = '',       
          this.buildingcompanyno = '',       
          this.buildingceo = '',       
          this.buildingaddress = '',       
          this.buildingaddressetc = '',       
          this.type = 0,       
          this.checkdate = 0,       
          this.managername = '',       
          this.managertel = '',       
          this.manageremail = '',       
          this.contractstartdate = '',       
          this.contractenddate = '',       
          this.contractprice = 0,       
          this.billingdate = 0,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.status = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json['id'] as int,
        name: json['name'] as String,
        companyno: json['companyno'] as String,
        ceo: json['ceo'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        buildingname: json['buildingname'] as String,
        buildingcompanyno: json['buildingcompanyno'] as String,
        buildingceo: json['buildingceo'] as String,
        buildingaddress: json['buildingaddress'] as String,
        buildingaddressetc: json['buildingaddressetc'] as String,
        type: json['type'] as int,
        checkdate: json['checkdate'] as int,
        managername: json['managername'] as String,
        managertel: json['managertel'] as String,
        manageremail: json['manageremail'] as String,
        contractstartdate: json['contractstartdate'] as String,
        contractenddate: json['contractenddate'] as String,
        contractprice: json['contractprice'] as int,
        billingdate: json['billingdate'] as int,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        status: json['status'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'companyno': companyno,'ceo': ceo,'address': address,'addressetc': addressetc,'buildingname': buildingname,'buildingcompanyno': buildingcompanyno,'buildingceo': buildingceo,'buildingaddress': buildingaddress,'buildingaddressetc': buildingaddressetc,'type': type,'checkdate': checkdate,'managername': managername,'managertel': managertel,'manageremail': manageremail,'contractstartdate': contractstartdate,'contractenddate': contractenddate,'contractprice': contractprice,'billingdate': billingdate,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'status': status,'date': date };

  Company clone() {
    return Company.fromJson(toJson());
  }
}

class CompanyManager {
  static const baseUrl = '/api/company';  

  static Future<List<Company>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Company>.empty(growable: true);
    }

    return result['items']
        .map<Company>((json) => Company.fromJson(json))
        .toList();
  }

  static Future<Company> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Company();
    }

    return Company.fromJson(result['item']);
  }

  static Future<int> insert(Company item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Company item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Company item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
