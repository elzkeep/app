import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

enum ReportStatus { none, newer, ing, check, complete }

class Report {
  int id;
  String title;
  int period;
  int number;
  String checkdate;
  String checktime;
  String content;
  ReportStatus status;
  Company company = Company();
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
      this.status = ReportStatus.none,
      Company? company,
      this.date = '',
      this.extra = const {},
      this.checked = false}) {
    if (company != null) {
      this.company = company;
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
        status: ReportStatus.values[json['status'] as int],
        company: Company.fromJson(json['extra']['company']),
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
        'status': status.index,
        'company': company.id,
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

  static update(Report item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Report item) async {
    await Http.delete(baseUrl, item.toJson());
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
}
