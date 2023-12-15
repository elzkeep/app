import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/item.dart';

class Dataitem {
  Data data;
  List<Item> items;

  Dataitem({required this.data, required this.items});

  factory Dataitem.empty() {
    return Dataitem(data: Data(), items: []);
  }
}
