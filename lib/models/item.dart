import 'package:common_control/common_control.dart';


enum ItemType {
    none, text, select, status
}
enum ItemStatus {
    none, good, warning, danger, notuse
}
  
class Item { 
  int id;
  String title;
  ItemType type;
  int value1;
  int value2;
  int value3;
  int value4;
  int value5;
  int value6;
  int value7;
  int value8;
  int value;
  ItemStatus status;
  int reason;
  String reasontext;
  int action;
  String actiontext;
  String image;
  int order;
  int data;
  String date;
  bool checked;
  Map<String, dynamic> extra;  

  Item({        
          this.id = 0,       
          this.title = '',       
          this.type = ItemType.none,       
          this.value1 = 0,       
          this.value2 = 0,       
          this.value3 = 0,       
          this.value4 = 0,       
          this.value5 = 0,       
          this.value6 = 0,       
          this.value7 = 0,       
          this.value8 = 0,       
          this.value = 0,       
          this.status = ItemStatus.none,       
          this.reason = 0,       
          this.reasontext = '',       
          this.action = 0,       
          this.actiontext = '',       
          this.image = '',       
          this.order = 0,       
          this.data = 0,       
          this.date = '',
          this.extra = const{},
          this.checked = false}) ;
  

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'] as int,
        title: json['title'] as String,
        type: ItemType.values[json['type'] as int],
        value1: json['value1'] as int,
        value2: json['value2'] as int,
        value3: json['value3'] as int,
        value4: json['value4'] as int,
        value5: json['value5'] as int,
        value6: json['value6'] as int,
        value7: json['value7'] as int,
        value8: json['value8'] as int,
        value: json['value'] as int,
        status: ItemStatus.values[json['status'] as int],
        reason: json['reason'] as int,
        reasontext: json['reasontext'] as String,
        action: json['action'] as int,
        actiontext: json['actiontext'] as String,
        image: json['image'] as String,
        order: json['order'] as int,
        data: json['data'] as int,
        date: json['date'] as String, extra: json['extra'] == null ? <String, dynamic>{} : json['extra'] as Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() =>
      { 'id': id,'title': title,'type': type.index,'value1': value1,'value2': value2,'value3': value3,'value4': value4,'value5': value5,'value6': value6,'value7': value7,'value8': value8,'value': value,'status': status.index,'reason': reason,'reasontext': reasontext,'action': action,'actiontext': actiontext,'image': image,'order': order,'data': data,'date': date };
}

class ItemManager {
  static const baseUrl = '/api/item';  

  static Future<List<Item>> find(
      {int page = 0, int pagesize = 20, String? params}) async {
    var result =
        await Http.get(baseUrl, {'page': page, 'pagesize': pagesize}, params);
    if (result == null || result['items'] == null) {
      return List<Item>.empty(growable: true);
    }

    return result['items']
        .map<Item>((json) => Item.fromJson(json))
        .toList();
  }

  static Future<Item> get(int id) async {
    var result = await Http.get('$baseUrl/$id');
    if (result == null || result['item'] == null) {
      return Item();
    }

    return Item.fromJson(result['item']);
  }

  static Future<int> insert(Item item) async {
    var result = await Http.insert(baseUrl, item.toJson());
    return result;
  }

  static update(Item item) async {
    await Http.put(baseUrl, item.toJson());
  }

  static delete(Item item) async {
    await Http.delete(baseUrl, item.toJson());
  }
}
