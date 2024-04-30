import 'package:common_control/common_control.dart';


enum UserLevel {
    none, normal, manager, admin, rootadmin
}
enum UserStatus {
    none, use, notuse
}
enum UserApproval {
    none, wait, reject, complete
}
  
class User { 
  int id;
  String loginid;
  String passwd;
  String name;
  String email;
  String tel;
  String zip;
  String address;
  String addressetc;
  String joindate;
  int careeryear;
  int careermonth;
  UserLevel level;
  double score;
  UserApproval approval;
  String educationdate;
  String educationinstitution;
  String specialeducationdate;
  String specialeducationinstitution;
  String rejectreason;
  UserStatus status;
  int company;
  int department;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  User({        
          this.id = 0,       
          this.loginid = '',       
          this.passwd = '',       
          this.name = '',       
          this.email = '',       
          this.tel = '',       
          this.zip = '',       
          this.address = '',       
          this.addressetc = '',       
          this.joindate = '',       
          this.careeryear = 0,       
          this.careermonth = 0,       
          this.level = UserLevel.none,       
          this.score = 0.0,       
          this.approval = UserApproval.none,       
          this.educationdate = '',       
          this.educationinstitution = '',       
          this.specialeducationdate = '',       
          this.specialeducationinstitution = '',       
          this.rejectreason = '',       
          this.status = UserStatus.none,       
          this.company = 0,       
          this.department = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        loginid: json['loginid'] as String,
        passwd: json['passwd'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        tel: json['tel'] as String,
        zip: json['zip'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        joindate: json['joindate'] as String,
        careeryear: json['careeryear'] as int,
        careermonth: json['careermonth'] as int,
        level: UserLevel.values[json['level'] as int],
        score: json['score'] as double,
        approval: UserApproval.values[json['approval'] as int],
        educationdate: json['educationdate'] as String,
        educationinstitution: json['educationinstitution'] as String,
        specialeducationdate: json['specialeducationdate'] as String,
        specialeducationinstitution: json['specialeducationinstitution'] as String,
        rejectreason: json['rejectreason'] as String,
        status: UserStatus.values[json['status'] as int],
        company: json['company'] as int,
        department: json['department'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'loginid': loginid,'passwd': passwd,'name': name,'email': email,'tel': tel,'zip': zip,'address': address,'addressetc': addressetc,'joindate': joindate,'careeryear': careeryear,'careermonth': careermonth,'level': level.index,'score': score,'approval': approval.index,'educationdate': educationdate,'educationinstitution': educationinstitution,'specialeducationdate': specialeducationdate,'specialeducationinstitution': specialeducationinstitution,'rejectreason': rejectreason,'status': status.index,'company': company,'department': department,'date': date };

  User clone() {
    return User.fromJson(toJson());
  }
}

class UserManager {
  static const baseUrl = '/api/user';  

  static Future<List<User>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<User>.empty(growable: true);
    }

    return result['items']
        .map<User>((json) => User.fromJson(json))
        .toList();
  }

  static Future<User> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return User();
    }

    return User.fromJson(result['item']);
  }

  static Future<int> insert(User item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(User item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(User item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
