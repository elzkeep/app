import 'package:common_control/common_control.dart';

class Facility {
  int id;
  int category;
  int parent;
  String value1;
  String value2;
  String value3;
  String value4;
  String value5;
  String value6;
  String value7;
  String value8;
  String value9;
  String value10;
  String value11;
  String value12;
  String value13;
  String value14;
  String value15;
  String value16;
  String value17;
  String value18;
  String value19;
  String value20;
  String content;
  int building;
  String date;
  bool checked;
  Map<String, dynamic> extra;

  Facility(
      {this.id = 0,
      this.category = 0,
      this.parent = 0,
      this.value1 = '',
      this.value2 = '',
      this.value3 = '',
      this.value4 = '',
      this.value5 = '',
      this.value6 = '',
      this.value7 = '',
      this.value8 = '',
      this.value9 = '',
      this.value10 = '',
      this.value11 = '',
      this.value12 = '',
      this.value13 = '',
      this.value14 = '',
      this.value15 = '',
      this.value16 = '',
      this.value17 = '',
      this.value18 = '',
      this.value19 = '',
      this.value20 = '',
      this.content = '',
      this.building = 0,
      this.date = '',
      this.extra = const {},
      this.checked = false});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
        id: json['id'] as int,
        category: json['category'] as int,
        parent: json['parent'] as int,
        value1: json['value1'] as String,
        value2: json['value2'] as String,
        value3: json['value3'] as String,
        value4: json['value4'] as String,
        value5: json['value5'] as String,
        value6: json['value6'] as String,
        value7: json['value7'] as String,
        value8: json['value8'] as String,
        value9: json['value9'] as String,
        value10: json['value10'] as String,
        value11: json['value11'] as String,
        value12: json['value12'] as String,
        value13: json['value13'] as String,
        value14: json['value14'] as String,
        value15: json['value15'] as String,
        value16: json['value16'] as String,
        value17: json['value17'] as String,
        value18: json['value18'] as String,
        value19: json['value19'] as String,
        value20: json['value20'] as String,
        content: json['content'] as String,
        building: json['building'] as int,
        date: json['date'] as String,
        extra: json['extra'] == null
            ? <String, dynamic>{}
            : json['extra'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'parent': parent,
        'value1': value1,
        'value2': value2,
        'value3': value3,
        'value4': value4,
        'value5': value5,
        'value6': value6,
        'value7': value7,
        'value8': value8,
        'value9': value9,
        'value10': value10,
        'value11': value11,
        'value12': value12,
        'value13': value13,
        'value14': value14,
        'value15': value15,
        'value16': value16,
        'value17': value17,
        'value18': value18,
        'value19': value19,
        'value20': value20,
        'content': content,
        'building': building,
        'date': date
      };

  Facility clone() {
    return Facility.fromJson(toJson());
  }
}

class FacilityManager {
  static const baseUrl = '/api/facility';

  static Future<List<Facility>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Facility>.empty(growable: true);
    }

    return result['items']
        .map<Facility>((json) => Facility.fromJson(json))
        .toList();
  }

  static Future<Facility> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Facility();
    }

    return Facility.fromJson(result['item']);
  }

  static Future<int> insert(Facility item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Facility item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Facility item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
