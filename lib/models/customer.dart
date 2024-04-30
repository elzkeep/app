import 'package:common_control/common_control.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';


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
  int contractvat;
  int contractday;
  int billingdate;
  int billingtype;
  String billingname;
  String billingtel;
  String billingemail;
  String address;
  String addressetc;
  int collectmonth;
  int collectday;
  String manager;
  String tel;
  String fax;
  int status;
  int salesuser;
  int user;
  Company company = Company();
  Building building = Building();
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
          this.contractvat = 0,       
          this.contractday = 0,       
          this.billingdate = 0,       
          this.billingtype = 0,       
          this.billingname = '',       
          this.billingtel = '',       
          this.billingemail = '',       
          this.address = '',       
          this.addressetc = '',       
          this.collectmonth = 0,       
          this.collectday = 0,       
          this.manager = '',       
          this.tel = '',       
          this.fax = '',       
          this.status = 0,       
          this.salesuser = 0,       
          this.user = 0,       
          Company? company,       
          Building? building,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) {
          if (building != null) {
              this.building = building;
          }
if (company != null) {
              this.company = company;
          }
    }
  

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
        contractvat: json['contractvat'] as int,
        contractday: json['contractday'] as int,
        billingdate: json['billingdate'] as int,
        billingtype: json['billingtype'] as int,
        billingname: json['billingname'] as String,
        billingtel: json['billingtel'] as String,
        billingemail: json['billingemail'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        collectmonth: json['collectmonth'] as int,
        collectday: json['collectday'] as int,
        manager: json['manager'] as String,
        tel: json['tel'] as String,
        fax: json['fax'] as String,
        status: json['status'] as int,
        salesuser: json['salesuser'] as int,
        user: json['user'] as int,
        company: Company.fromJson(json['extra']['company']),
        building: Building.fromJson(json['extra']['building']),
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'type': type.index,'checkdate': checkdate,'managername': managername,'managertel': managertel,'manageremail': manageremail,'contractstartdate': contractstartdate,'contractenddate': contractenddate,'contractprice': contractprice,'contractvat': contractvat,'contractday': contractday,'billingdate': billingdate,'billingtype': billingtype,'billingname': billingname,'billingtel': billingtel,'billingemail': billingemail,'address': address,'addressetc': addressetc,'collectmonth': collectmonth,'collectday': collectday,'manager': manager,'tel': tel,'fax': fax,'status': status,'salesuser': salesuser,'user': user,'company': company.id,'building': building.id,'date': date };

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
