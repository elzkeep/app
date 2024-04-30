import 'package:common_control/common_control.dart';


  
class Department { 
  int id;
  String name;
  int status;
  int order;
  int parent;
  int company;
  int master;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Department({        
          this.id = 0,       
          this.name = '',       
          this.status = 0,       
          this.order = 0,       
          this.parent = 0,       
          this.company = 0,       
          this.master = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
        id: json['id'] as int,
        name: json['name'] as String,
        status: json['status'] as int,
        order: json['order'] as int,
        parent: json['parent'] as int,
        company: json['company'] as int,
        master: json['master'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'name': name,'status': status,'order': order,'parent': parent,'company': company,'master': master,'date': date };

  Department clone() {
    return Department.fromJson(toJson());
  }
}

class DepartmentManager {
  static const baseUrl = '/api/department';  

  static Future<List<Department>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Department>.empty(growable: true);
    }

    return result['items']
        .map<Department>((json) => Department.fromJson(json))
        .toList();
  }

  static Future<Department> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Department();
    }

    return Department.fromJson(result['item']);
  }

  static Future<int> insert(Department item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Department item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Department item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
