import 'dart:convert';

import 'package:common_control/common_control.dart';

class FacilityItem {
  int id;
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
  int building;
  Map<String, dynamic> extra;

  FacilityItem(
      {this.id = 0,
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
      this.building = 0,
      this.extra = const {}});

  factory FacilityItem.fromJson(Map<String, dynamic> json) {
    return FacilityItem(
        id: json['id'] as int,
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
        building: json['building'] as int,
        extra: json['extra'] == null
            ? <String, dynamic>{}
            : json['extra'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
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
        'building': building,
      };

  FacilityItem clone() {
    return FacilityItem.fromJson(toJson());
  }
}
