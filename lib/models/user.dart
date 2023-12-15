import 'package:common_control/common_control.dart';


enum UserLevel {
    none, normal, premium, admin
}
enum UserStatus {
    none, use, notuser
}
  
class User { 
  int id;
  String email;
  String passwd;
  String name;
  UserLevel level;
  UserStatus status;
  double elo;
  int count;
  String image;
  String profile;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  User({        
          this.id = 0,       
          this.email = '',       
          this.passwd = '',       
          this.name = '',       
          this.level = UserLevel.none,       
          this.status = UserStatus.none,       
          this.elo = 0.0,       
          this.count = 0,       
          this.image = '',       
          this.profile = '',       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        email: json['email'] as String,
        passwd: json['passwd'] as String,
        name: json['name'] as String,
        level: UserLevel.values[json['level'] as int],
        status: UserStatus.values[json['status'] as int],
        elo: json['elo'] as double,
        count: json['count'] as int,
        image: json['image'] as String,
        profile: json['profile'] as String,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'email': email,'passwd': passwd,'name': name,'level': level.index,'status': status.index,'elo': elo,'count': count,'image': image,'profile': profile,'date': date };
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
