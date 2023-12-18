import 'package:common_control/common_control.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';
import 'package:zkeep/screens/data/dataitem/high.dart';
import 'package:zkeep/screens/data/dataitem/low.dart';
import 'package:zkeep/screens/data/dataitem/change.dart';
import 'package:zkeep/screens/data/dataitem/load.dart';
import 'package:zkeep/screens/data/dataitem/generator.dart';
import 'package:zkeep/screens/data/dataitem/etc.dart';
import 'package:zkeep/screens/data/dataitem/sunlight.dart';
import 'package:zkeep/screens/data/dataitem/charger.dart';

class WriteController extends GetxController {
  WriteController(this.id, this.category);

  final id;
  final category;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _datas = [].obs;
  get datas => _datas;
  set datas(value) => _datas.value = value;

  final _title = ''.obs;
  String get title => _title.value;
  set title(String value) => _title.value = value;

  Dataitem getData(index, order, suborder) {
    print('category : $category');
    if (category == 1) {
      return low(index, order, suborder);
    } else if (category == 2) {
      return high(index, order, suborder);
    } else if (category == 3) {
      return change(index, order, suborder);
    } else if (category == 4) {
      return load(index, order, suborder);
    } else if (category == 5) {
      return generator(index, order, suborder);
    } else if (category == 6) {
      return etc(index, order, suborder);
    } else if (category == 7) {
      return sunlight(index, order, suborder);
    } else if (category == 8) {
      return charger(index, order, suborder);
    }
    return Dataitem.empty();
  }

  int getLength() {
    if (category == 1) {
      final item = lows(0, 0, 0);
      return item.length;
    } else if (category == 2) {
      final item = highs(0, 0, 0);
      return item.length;
    } else if (category == 3) {
      final item = changes(0, 0, 0);
      return item.length;
    } else if (category == 4) {
      final item = loads(0, 0, 0);
      return item.length;
    } else if (category == 5) {
      final item = generators(0, 0, 0);
      return item.length;
    } else if (category == 6) {
      final item = etcs(0, 0, 0);
      return item.length;
    } else if (category == 7) {
      final item = sunlights(0, 0, 0);
      return item.length;
    } else if (category == 8) {
      final item = chargers(0, 0, 0);
      return item.length;
    }

    return 0;
  }

  getDataitem(index, order, suborder) {
    Dataitem item = getData(index, order, suborder);
    for (var j = 0; j < item.items.length; j++) {
      if (item.items[j].type == ItemType.select) {
        if (item.items[j].extra['default'] != null) {
          item.items[j].value = item.items[j].extra['default'];
        }

        continue;
      }
      if (item.items[j].type != ItemType.status) {
        continue;
      }

      item.items[j].status = ItemStatus.notuse;
      item.items[j].extra = {
        'reasontext': TextEditingController(),
        'actiontext': TextEditingController(),
      };
    }

    item.data.extra = {'text': TextEditingController()};
    item.data.extra['text'].text = item.data.title;

    return item;
  }

  @override
  onInit() {
    super.onInit();

    List<Dataitem> datas = [];

    final length = getLength();
    for (var i = 1; i <= length; i++) {
      datas.add(getDataitem(i, 0, 0));
    }

    items = datas;

    final titles = [
      '저압설비',
      '고압설비',
      '변전설비',
      '부하설비',
      '발전설비',
      '기타안전설비',
      '태양광 발전설비',
      '전기차충전기'
    ];

    title = '창천초등학교 - ${titles[category - 1]}';
  }

  add(index) {
    final datas = getDataitem(index, items.length, 1);

    var pos = 0;
    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      if (item.data.category <= index) {
        pos++;
        continue;
      }

      break;
    }

    items.insert(pos, datas);
    redraw();
  }

  remove(index) {
    print('delete = $index');
    items.value.removeAt(index);
    redraw();
  }

  redraw() {
    _items.refresh();
  }
}
