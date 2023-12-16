import 'dart:convert';

import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/item.dart';

class Dataitem {
  int order;
  Data data;
  List<Item> items;

  Dataitem({required this.order, required this.data, required this.items});

  factory Dataitem.empty() {
    return Dataitem(order: 0, data: Data(), items: []);
  }

  factory Dataitem.fromJson(Map<String, dynamic> json) {
    List<Item> items = [];

    var item = json['items'] as List<dynamic>;
    for (var i = 0; i < item.length; i++) {
      items.add(Item.fromJson(item[i]));
    }

    return Dataitem(
      order: json['order'] as int,
        data: Data.fromJson(json['data']),
        items: items);
  }

  Map<String, dynamic> toJson() =>
      { 'order': order, 'data': data, 'items': items };

  Dataitem clone() {
    return Dataitem.fromJson(toJson());
  }
}
