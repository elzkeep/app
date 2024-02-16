import 'package:common_control/common_control.dart';


enum CustomerType {
    none, direct, outsourcing
}
  
class Customer { 
  int id;
  CustomerType type;
  int checkdate;
  String managername;
  String managertel;
  String manageremail;
  String contractstartdate;
  String contractenddate;
  int contractprice;
  int contractday;
  int billingdate;
  String billingname;
  String billingtel;
  String billingemail;
  int status;
  int company;
  int building;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Customer({        
          this.id = 0,       
          this.type = CustomerType.none,       
          this.checkdate = 0,       
          this.managername = '',       
          this.managertel = '',       
          this.manageremail = '',       
          this.contractstartdate = '',       
          this.contractenddate = '',       
          this.contractprice = 0,       
          this.contractday = 0,       
          this.billingdate = 0,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.status = 0,       
          this.company = 0,       
          this.building = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'] as int,
        type: CustomerType.values[json['type'] as int],
        checkdate: json['checkdate'] as int,
        managername: json['managername'] as String,
        managertel: json['managertel'] as String,
        manageremail: json['manageremail'] as String,
        contractstartdate: json['contractstartdate'] as String,
        contractenddate: json['contractenddate'] as String,
        contractprice: json['contractprice'] as int,
        contractday: json['contractday'] as int,
        billingdate: json['billingdate'] as int,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        status: json['status'] as int,
        company: json['company'] as int,
        building: json['building'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'type': type.index,'checkdate': checkdate,'managername': managername,'managertel': managertel,'manageremail': manageremail,'contractstartdate': contractstartdate,'contractenddate': contractenddate,'contractprice': contractprice,'contractday': contractday,'billingdate': billingdate,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'status': status,'company': company,'building': building,'date': date };

  Customer clone() {
    return Customer.fromJson(toJson());
  }
}

class CustomerManager {
  static const baseUrl = '/api/customer';  

  static Future<List<Customer>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Customer>.empty(growable: true);
    }

    return result['items']
        .map<Customer>((json) => Customer.fromJson(json))
        .toList();
  }

  static Future<Customer> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Customer();
    }

    return Customer.fromJson(result['item']);
  }

  static Future<int> insert(Customer item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Customer item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Customer item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
