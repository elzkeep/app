import 'package:common_control/common_control.dart';
import 'package:zkeep/components/box_title.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/status.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/write_controller.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class WriteScreen extends CWidget {
  WriteScreen({super.key});

  final c = Get.find<WriteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Layout(
        title: c.title,
        popup: true,
        child: CFixedBottom(bottom: bottom(), children: [
          SingleChildScrollView(
              child: CColumn(gap: 20, children: [
            data(),
            const SizedBox(height: 20),
          ])),
        ]),
      ),
    );
  }

  bottom() {
    return CRow(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        gap: 10,
        children: [
          CButton(
            text: '취소',
            flex: 1,
            size: CButtonSize.normal,
            type: CButtonStyle.outlined,
            onPressed: () => clickCancel(),
          ),
          CButton(
            text: '확인',
            flex: 1,
            size: CButtonSize.normal,
            onPressed: () => clickSave(),
          ),
        ]);
  }

  clickCancel() {
    Get.back();
    Get.delete<WriteController>();
  }

  clickSave() async {
    await c.insert();
    Get.back();
    Get.delete<WriteController>();
  }

  data() {
    List<Widget> items = [];
    List<Widget> subitems = [];

    const titleStyle = TextStyle(color: Config.titleColor);

    String oldParent = '';
    bool parentStart = false;
    for (var i = 0; i < c.items.length; i++) {
      final item = c.items[i];
      final widget = category(i, item);

      if (parentStart == false) {
        if (item.parent != oldParent) {
          parentStart = true;

          subitems.add(CText(item.parent, textStyle: titleStyle));
          subitems.add(widget);
        } else {
          items.add(widget);
        }
      } else {
        if (item.parent != oldParent) {
          parentStart = false;

          // 이제 넣어줘야 함
          items.add(CRound(
              backgroundColor: Config.backgroundColor,
              child: CColumn(
                  gap: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: subitems)));

          subitems = [];

          if (item.parent == '') {
            items.add(widget);
          } else {
            parentStart = true;

            subitems.add(CText(item.parent, textStyle: titleStyle));
            subitems.add(widget);
          }

        } else {
          subitems.add(widget);
        }
      }

      oldParent = item.parent;
    }

    if (parentStart == true) {
          items.add(CRound(
              backgroundColor: Config.backgroundColor,
              child: CColumn(
                  gap: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: subitems)));

    }

    return CColumn(gap: 20, children: items);
  }

  category(index, Dataitem entry) {
    List<Widget> widgets = [];

    if (entry.data.type == DataType.multi) {
      final widget = BoxTitle(
        color: index == 0 ? Config.titleColor : Colors.black,
        text: entry.data.title,
        controller: entry.data.extra['text'],
        expand: entry.data.order == 0,
        onExpand: (expand) {
          if (entry.data.extra['text'] != null) {
            entry.data.title = entry.data.extra['text'].text;
          }
          if (expand) {
            c.add(entry.data.category);
          } else {
            c.remove(index);
          }
        },
      );
      widgets.add(widget);
    } else {
      final widget = CText(entry.data.title);
      widgets.add(widget);
    }

    List<Item> values = [];

    for (var i = 0; i < entry.items.length; i++) {
      final item = entry.items[i];

      var visible = false;
      if (item.extra['visible'] != null) {
        final pos = item.extra['visible']! as int;
        if (entry.items[0].value == pos) {
          visible = true;
        }
      } else {
        visible = true;
      }

      if (visible == false) {
        continue;
      }

      if (item.type == ItemType.none) {
        final widget = CColumn(gap: 10, children: [
          CText(item.title),
        ]);

        widgets.add(widget);
      } else if (item.type == ItemType.text) {
        values.add(item);
        if (item.extra['end'] != null) {
          List<Widget> datas = [];
          int length = values.length;
          if (values.length % 2 != 0) {
            length--;
          }
          for (var i = 0; i < length; i += 2) {
            final item1 = values[i];
            final item2 = values[i + 1];
            datas.add(CRow(gap: 10, children: [
              Expanded(
                  child: CTextField(
                text: item1.title,
                suffixText: item1.unit,
                controller: item1.extra['text'],
                filledColor: Colors.white,
              )),
              Expanded(
                  child: CTextField(
                      text: item2.title,
                      suffixText: item2.unit,
                      controller: item2.extra['text'],
                      filledColor: Colors.white)),
            ]));
          }

          if (values.length % 2 != 0) {
            final item1 = values[values.length - 1];
            datas.add(CRow(gap: 10, children: [
              Expanded(
                  child: CTextField(
                text: item1.title,
                suffixText: item1.unit,
                controller: item1.extra['text'],
                filledColor: Colors.white,
              )),
            ]));
          }

          final widget = CColumn(gap: 10, children: datas);

          widgets.add(widget);

          values = [];
        }
      } else if (item.type == ItemType.select) {
        bool empty = true;
        if (item.extra['default'] != null) {
          empty = false;
        }

        final widget = CColumn(gap: 10, children: [
          CText(item.title),
          CSelectbox(
              empty: empty,
              backgroundColor: Colors.white,
              items: item.extra['select'],
              selected: entry.items[i].value,
              onSelected: (pos) {
                entry.items[i].value = pos;
                c.redraw();
              }),
        ]);

        widgets.add(widget);
      } else if (item.type == ItemType.status) {
        final widget = Status(
            title: item.title,
            item: item,
            onSelected: (value) {
              entry.items[i] = value;
              c.redraw();
            });

        widgets.add(widget);
      }
    }

    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            gap: 20,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets));
  }
}
