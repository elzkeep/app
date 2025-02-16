import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/user.dart';
import 'package:zkeep/models/building.dart';

enum ReportStatus { none, newer, ing, check, complete }

class Report {
  int id;
  String title;
  int period;
  int number;
  String checkdate;
  String checktime;
  String content;
  String image;
  String sign1;
  String sign2;
  ReportStatus status;
  Company company = Company();
  User user = User();
  Building building = Building();
  String date;
  bool checked;
  Map<String, dynamic> extra;

  Report(
      {this.id = 0,
      this.title = '',
      this.period = 0,
      this.number = 0,
      this.checkdate = '',
      this.checktime = '',
      this.content = '',
      this.image = '',
      this.sign1 = '',
      this.sign2 = '',
      this.status = ReportStatus.none,
      Company? company,
      User? user,
      Building? building,
      this.date = '',
      this.extra = const {},
      this.checked = false}) {
    if (company != null) {
      this.company = company;
    }
    if (user != null) {
      this.user = user;
    }
    if (building != null) {
      this.building = building;
    }
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        id: json['id'] as int,
        title: json['title'] as String,
        period: json['period'] as int,
        number: json['number'] as int,
        checkdate: json['checkdate'] as String,
        checktime: json['checktime'] as String,
        content: json['content'] as String,
        image: json['image'] as String,
        sign1: json['sign1'] as String,
        sign2: json['sign2'] as String,
        status: ReportStatus.values[json['status'] as int],
        company: Company.fromJson(json['extra']['company']),
        user: User.fromJson(json['extra']['user']),
        building: Building.fromJson(json['extra']['building']),
        date: json['date'] as String,
        extra: json['extra'] == null
            ? <String, dynamic>{}
            : json['extra'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'period': period,
        'number': number,
        'checkdate': checkdate,
        'checktime': checktime,
        'content': content,
        'image': image,
        'sign1': sign1,
        'sign2': sign2,
        'status': status.index,
        'company': company.id,
        'user': user.id,
        'building': building.id,
        'date': date
      };

  Report clone() {
    return Report.fromJson(toJson());
  }
}

class ReportManager {
  static const baseUrl = '/api/report';

  static Future<List<Report>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Report>.empty(growable: true);
    }

    return result['items']
        .map<Report>((json) => Report.fromJson(json))
        .toList();
  }

  static Future<Report> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Report();
    }

    return Report.fromJson(result['item']);
  }

  static Future<int> insert(Report item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static Future<List<Report>> search(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result = await Http.get(
        '$baseUrl/search/$page', {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Report>.empty(growable: true);
    }

    return result['items']
        .map<Report>((json) => Report.fromJson(json))
        .toList();
  }

  static update(Report item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Report item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
