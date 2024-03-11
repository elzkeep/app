import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/cselectbutton.dart';
import 'package:zkeep/models/item.dart';

class StatusItem {
  StatusItem(
      {this.value = 4,
      this.reason = 0,
      this.reasonText = '',
      this.action = 0,
      this.actionText = '',
      this.image = ''});

  int value;
  int reason;
  String reasonText;
  int action;
  String actionText;
  String image;
}

class Status extends CWidget {
  Status(
      {super.key,
      this.title = '',
      required this.item,
      required this.onSelected});

  final String title;
  final Item item;
  final Function(Item) onSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    List<String> reasonsName = [
      '없음',
      '직접입력',
      '누전',
      '단락',
      '단선',
      '작동불량',
      '파손',
      '오염',
      '노후',
      '누유',
      '누수',
      '균열',
      '발열',
      '이상음'
    ];

    List<CItem> reasons = [];

    for (var i = 0; i < reasonsName.length; i++) {
      final item = reasonsName[i];
      reasons.add(CItem(id: i, value: item));
    }

    List<String> actionName = [
      '없음',
      '직접입력',
      '점검중',
      '조치완료',
      '수리 및 정비요함',
      '교체요함',
      '설치요함',
    ];

    List<CItem> actions = [];

    for (var i = 0; i < actionName.length; i++) {
      final item = actionName[i];
      actions.add(CItem(id: i, value: item));
    }

    if (title != '') {
      items.add(CText(title));
    }

    items.add(CSelectButton(
        items: const ['적합', '부적합', '요주의', '해당없음'],
        index: item.status.index,
        onSelected: (index) {
          item.status = ItemStatus.values[index];
          onSelected(item);
        }));

    if (item.status == ItemStatus.warning || item.status == ItemStatus.danger) {
      final widget = CRow(children: [
        Expanded(
          child: CContainer(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE0E0E0),
                    width: 1,
                  ),
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CColumn(gap: 10, children: [
                CText('사유'),
                CSelectbox(
                    backgroundColor: Colors.white,
                    items: reasons,
                    selected: item.reason,
                    onSelected: (pos) {
                      item.reason = pos;
                      onSelected(item);
                    }),
                item.reason == 1
                    ? CTextField(
                        textStyle: const TextStyle(fontSize: 14),
                        filledColor: Colors.white,
                        controller: item.extra['reasontext'])
                    : const SizedBox.shrink(),
                CText('조치사항'),
                CSelectbox(
                    backgroundColor: Colors.white,
                    items: actions,
                    selected: item.action,
                    onSelected: (pos) {
                      item.action = pos;
                      onSelected(item);
                    }),
                item.action == 1
                    ? CTextField(
                        textStyle: const TextStyle(fontSize: 14),
                        filledColor: Colors.white,
                        controller: item.extra['actiontext'])
                    : const SizedBox.shrink(),
                CText('사진'),
                item.image == ''
                    ? CContainer(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: const Color(0xffE0E0E0),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(CupertinoIcons.plus),
                        onTap: () async {
                          final returnedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (returnedImage == null) return;
                          item.image = returnedImage.path;
                          onSelected(item);
                        },
                      )
                    : CContainer(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                        ))
                // : CContainer(
                //     width: 100,
                //     height: 100,
                //     child: ?????
                //         ? Image.asset(
                //             item.image,
                //             fit: BoxFit.cover,
                //           )
                //         : Image.network(
                //             item.image,
                //             fit: BoxFit.cover,
                //           ))
              ])),
        ),
      ]);

      items.add(widget);
    }

    return CColumn(gap: 10, children: items);
  }
}
