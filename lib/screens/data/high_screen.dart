import 'package:common_control/common_control.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zkeep/components/box_title.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/status.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/high_controller.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/item.dart';

class HighScreen extends CWidget {
  HighScreen({super.key});

  final c = Get.find<HighController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '창천초등학교 - 고압설비',
      popup: true,
      child: CFixedBottom(children: [
        SingleChildScrollView(
            child: Obx(() => CColumn(gap: 20, children: [
                  volt(),
                  data(),
                  const SizedBox(height: 20),
                ]))),
      ], bottom: bottom()),
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
  }

  clickSave() {
    Get.back();
  }

  volt() {
    return CRound(
      backgroundColor: Config.backgroundColor,
      child: CColumn(
        gap: 10,
        children: [
          CText('전압 및 전류 계측값'),
          CTextField(text: '전압', suffixText: 'kV', filledColor: Colors.white,),
          CRow(gap: 10, children: [
            Expanded(child: CTextField(text: 'A상', suffixText: 'A', filledColor: Colors.white,)),
            Expanded(child: CTextField(text: 'B상', suffixText: 'A', filledColor: Colors.white)),
          ]),
          CRow(gap: 10, children: [
            Expanded(child: CTextField(text: 'C상', suffixText: 'A', filledColor: Colors.white,)),
            Expanded(child: CTextField(text: 'N상', suffixText: 'A', filledColor: Colors.white)),
          ])
    ]));
  }

  data() {
    List<Widget> items = [];

    for (var i = 0; i < c.items.length; i++) {
      final item = c.items[i];
      items.add(category(i, item));
    }
    return CColumn(gap: 20, children: items);
  }

  category(index, entry) {
    List<Widget> widgets = [];

    if (entry.data.type == DataType.multi) {
      final widget = BoxTitle(
        color: index == 0 ? Config.titleColor : Colors.black,
        text: entry.data.title,
        controller: TextEditingController(),
        expand: entry.data.order == 0,
        onExpand: (expand) {
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

    for (var i = 0; i < entry.items.length; i++) {
      final item = entry.items[i];

      if (item.type == ItemType.select) {
        final widget = CColumn(gap: 10, children: [
            CText(item.title),
            CSelectbox(
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
