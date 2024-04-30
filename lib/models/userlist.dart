import 'package:common_control/common_control.dart';


  
class Userlist { 
  int id;
  String loginid;
  String passwd;
  String name;
  String email;
  String tel;
  String address;
  String addressetc;
  String joindate;
  int careeryear;
  int careermonth;
  int level;
  double score;
  int approval;
  String educationdate;
  String educationinstitution;
  String specialeducationdate;
  String specialeducationinstitution;
  String rejectreason;
  int status;
  int company;
  int department;
  String date;
  double totalscore;
  bool checked;
  Map<String, dynamic> extra;  

  Userlist({        
          this.id = 0,       
          this.loginid = '',       
          this.passwd = '',       
          this.name = '',       
          this.email = '',       
          this.tel = '',       
          this.address = '',       
          this.addressetc = '',       
          this.joindate = '',       
          this.careeryear = 0,       
          this.careermonth = 0,       
          this.level = 0,       
          this.score = 0.0,       
          this.approval = 0,       
          this.educationdate = '',       
          this.educationinstitution = '',       
          this.specialeducationdate = '',       
          this.specialeducationinstitution = '',       
          this.rejectreason = '',       
          this.status = 0,       
          this.company = 0,       
          this.department = 0,       
          this.date = '',       
          this.totalscore = 0.0,
          this.extra = const{},
          this.checked = false}) ;
  

  factory Userlist.fromJson(Map<String, dynamic> json) {
    return Userlist(
        id: json['id'] as int,
        loginid: json['loginid'] as String,
        passwd: json['passwd'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        tel: json['tel'] as String,
        address: json['address'] as String,
        addressetc: json['addressetc'] as String,
        joindate: json['joindate'] as String,
        careeryear: json['careeryear'] as int,
        careermonth: json['careermonth'] as int,
        level: json['level'] as int,
        score: json['score'] as double,
        approval: json['approval'] as int,
        educationdate: json['educationdate'] as String,
        educationinstitution: json['educationinstitution'] as String,
        specialeducationdate: json['specialeducationdate'] as String,
        specialeducationinstitution: json['specialeducationinstitution'] as String,
        rejectreason: json['rejectreason'] as String,
        status: json['status'] as int,
        company: json['company'] as int,
        department: json['department'] as int,
        date: json['date'] as String,
        totalscore: json['totalscore'] as double, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'loginid': loginid,'passwd': passwd,'name': name,'email': email,'tel': tel,'address': address,'addressetc': addressetc,'joindate': joindate,'careeryear': careeryear,'careermonth': careermonth,'level': level,'score': score,'approval': approval,'educationdate': educationdate,'educationinstitution': educationinstitution,'specialeducationdate': specialeducationdate,'specialeducationinstitution': specialeducationinstitution,'rejectreason': rejectreason,'status': status,'company': company,'department': department,'date': date,'totalscore': totalscore };

  Userlist clone() {
    return Userlist.fromJson(toJson());
  }
}

class UserlistManager {
  static const baseUrl = '/api/userlist';  

  static Future<List<Userlist>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Userlist>.empty(growable: true);
    }

    return result['items']
        .map<Userlist>((json) => Userlist.fromJson(json))
        .toList();
  }

  static Future<Userlist> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Userlist();
    }

    return Userlist.fromJson(result['item']);
  }

  static Future<int> insert(Userlist item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Userlist item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Userlist item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
