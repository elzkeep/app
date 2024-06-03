import 'package:common_control/common_control.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/list_controller.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/controllers/main_controller.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/screens/data/dataitem/change.dart';
import 'package:zkeep/screens/data/dataitem/charger.dart';
import 'package:zkeep/screens/data/dataitem/ess.dart';
import 'package:zkeep/screens/data/dataitem/etc.dart';
import 'package:zkeep/screens/data/dataitem/fuel.dart';
import 'package:zkeep/screens/data/dataitem/generator.dart';
import 'package:zkeep/screens/data/dataitem/high.dart';
import 'package:zkeep/screens/data/dataitem/load.dart';
import 'package:zkeep/screens/data/dataitem/low.dart';
import 'package:zkeep/screens/data/dataitem/sunlight.dart';
import 'package:zkeep/screens/data/dataitem/thermography.dart';
import 'package:zkeep/screens/data/dataitem/ups.dart';
import 'package:zkeep/screens/data/dataitem/wind.dart';

class WriteController extends GetxController {
  WriteController(this.id, this.topcategory, this.report, this.disable);

  final int id;
  final int topcategory;
  final Report report;
  final bool disable;

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
    if (topcategory == 1) {
      return low(index, order, suborder, report.period);
    } else if (topcategory == 2) {
      return high(index, order, suborder, report.period);
    } else if (topcategory == 3) {
      return change(index, order, suborder, report.period);
    } else if (topcategory == 4) {
      return load(index, order, suborder);
    } else if (topcategory == 5) {
      return generator(index, order, suborder, report.period);
    } else if (topcategory == 6) {
      return etc(index, order, suborder);
    } else if (topcategory == 7) {
      return sunlight(index, order, suborder);
    } else if (topcategory == 8) {
      return charger(index, order, suborder, report.period);
    } else if (topcategory == 9) {
      return ess(index, order, suborder);
    } else if (topcategory == 10) {
      return ups(index, order, suborder);
    } else if (topcategory == 11) {
      return fuel(index, order, suborder);
    } else if (topcategory == 12) {
      return wind(index, order, suborder);
    } else if (topcategory == 14) {
      return thermography(index, order, suborder);
    }
    return Dataitem.empty();
  }

  int getLength() {
    if (topcategory == 1) {
      final item = lows(0, 0, 0, report.period);
      return item.length;
    } else if (topcategory == 2) {
      final item = highs(0, 0, 0, report.period);
      return item.length;
    } else if (topcategory == 3) {
      final item = changes(0, 0, 0, report.period);
      return item.length;
    } else if (topcategory == 4) {
      final item = loads(0, 0, 0);
      return item.length;
    } else if (topcategory == 5) {
      final item = generators(0, 0, 0, report.period);
      return item.length;
    } else if (topcategory == 6) {
      final item = etcs(0, 0, 0);
      return item.length;
    } else if (topcategory == 7) {
      final item = sunlights(0, 0, 0);
      return item.length;
    } else if (topcategory == 8) {
      final item = chargers(0, 0, 0, report.period);
      return item.length;
    } else if (topcategory == 9) {
      final item = esss(0, 0, 0);
      return item.length;
    } else if (topcategory == 10) {
      final item = upss(0, 0, 0);
      return item.length;
    } else if (topcategory == 11) {
      final item = fuels(0, 0, 0);
      return item.length;
    } else if (topcategory == 12) {
      final item = winds(0, 0, 0);
      return item.length;
    } else if (topcategory == 14) {
      final item = thermographys(0, 0, 0);
      return item.length;
    }

    return 0;
  }

  getDataitem(index, order, suborder) {
    Dataitem item = getData(index, order, suborder);

    item.data.topcategory = topcategory;

    for (var j = 0; j < item.items.length; j++) {
      if (item.items[j].type == ItemType.select) {
        if (item.items[j].extra['default'] != null) {
          item.items[j].value = item.items[j].extra['default'];
        }

        continue;
      }

      if (item.items[j].type == ItemType.text) {
        var extra = item.items[j].extra;

        var newExtra = <String, dynamic>{};

        for (var key in extra.keys) {
          newExtra[key] = extra[key];
        }

        newExtra['text'] = TextEditingController();

        item.items[j].extra = newExtra;
      } else if (item.items[j].type == ItemType.status) {
        item.items[j].status = ItemStatus.notuse;

        item.items[j].extra = {
          'reasontext': TextEditingController(),
          'actiontext': TextEditingController(),
          'image': false,
        };
      }
    }

    item.data.extra = {'text': TextEditingController()};
    item.data.extra['text'].text = item.data.title;

    return item;
  }

  @override
  onInit() async {
    super.onInit();

    final titles = [
      '저압설비',
      '고압설비',
      '변전설비',
      '부하설비',
      '발전설비',
      '기타안전설비',
      '태양광 발전설비',
      '전기차 충전기',
      'ESS',
      'UPS',
      '연료전지',
      '풍력발전',
      '수력발전',
      '적외선 열화상'
    ];
    title = '${report.title} - ${titles[topcategory - 1]}';
    print('title = $title');

    List<Dataitem> datas = [];

    print('report=$id&topcategory=$topcategory');
    final ret =
        await DataManager.find(params: 'report=$id&topcategory=$topcategory');

    print(ret);
    if (ret.isEmpty) {
      print('empty');
      final length = getLength();

      for (var i = 1; i <= length; i++) {
        datas.add(getDataitem(i, 0, 0));
      }

      items = datas;
      return;
    }

    print('^^^^^^^^^^^^^^^^^');
    final ret2 = await ItemManager.find(params: 'params=report=$id');

    for (var i = 0; i < ret.length; i++) {
      final data = ret[i];
      print('title = ${data.title}');
      Dataitem dataitem = getDataitem(data.category, 0, 0);
      dataitem.data.title = data.title;
      dataitem.data.extra['text'].text = data.title;

      var pos = 0;
      for (var j = 0; j < ret2.length; j++) {
        final item = ret2[j];
        if (item.data != data.id) {
          continue;
        }

        dataitem.items[pos].value = item.value;
        if (dataitem.items[pos].type == ItemType.text) {
          dataitem.items[pos].extra['text'].text = item.content;
        } else if (dataitem.items[pos].type == ItemType.select) {
        } else if (dataitem.items[pos].type == ItemType.status) {
          dataitem.items[pos].status = item.status;
          dataitem.items[pos].reason = item.reason;
          dataitem.items[pos].action = item.action;

          dataitem.items[pos].extra['reasontext'].text = item.reasontext;
          dataitem.items[pos].extra['actiontext'].text = item.actiontext;
        }

        if (dataitem.items[pos].status == ItemStatus.danger ||
            dataitem.items[pos].status == ItemStatus.warning) {
          print(item.id);
          if (item.image != '') {
            dataitem.items[pos].image =
                '${Config.serverUrl}/webdata/${item.image}';
            dataitem.items[pos].extra['image'] = true;
          }
        }

        pos++;
      }

      datas.add(dataitem);
    }

    items = datas;
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
    items.value.removeAt(index);
    redraw();
  }

  redraw() {
    _items.refresh();
  }

  insert() async {
    print('======================================');
    for (var j = 0; j < items.length; j++) {
      final entry = items[j];

      entry.data.order = j;
      entry.data.report = id;
      entry.data.company = report.company.id;

      print('category = ${entry.data.category}');
      if (entry.data.type == DataType.multi) {
        print('*********************');
        print(entry.data.extra['text'].text);
        entry.data.title = entry.data.extra['text'].text;
      } else {
        print(entry.data.title);
      }

      for (var i = 0; i < entry.items.length; i++) {
        final item = entry.items[i];

        if (item.type == ItemType.none) {
        } else if (item.type == ItemType.text) {
          print(entry.items[i].extra['text'].text);
          item.content = item.extra['text'].text;
        } else if (item.type == ItemType.select) {
          print('${entry.items[i].value}');
        } else if (item.type == ItemType.status) {
          print('${entry.items[i].status}');
          print('${entry.items[i].reason}');
          print('${entry.items[i].action}');
          print(entry.items[i].extra['reasontext'].text);
          print(entry.items[i].extra['actiontext'].text);

          item.reasontext = item.extra['reasontext'].text;
          item.actiontext = item.extra['actiontext'].text;
        }

        if (item.status == ItemStatus.danger ||
            item.status == ItemStatus.warning) {
          if (item.image != '') {
            var result =
                await Http.upload('/api/upload/index', "file", item.image);
            item.image = result;
          }
        }
      }
    }

    print(items.runtimeType);

    await DataitemManager.insert(items.value);
    if (report.status == ReportStatus.newer) {
      report.status = ReportStatus.ing;
      await ReportManager.update(report);
    }
    final c = Get.find<ViewController>();
    c.data[topcategory - 1] = true;
    if (Get.isRegistered<ListController>()) {
      final c = Get.find<ListController>();
      c.reset();
    }
    if (Get.isRegistered<MainController>()) {
      final c = Get.find<MainController>();
      c.reset();
    }
  }
}
