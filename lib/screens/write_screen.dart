import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/Cformtitle.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/ctablecalendar.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/controllers/write_controller.dart';
import 'package:zkeep/models/building.dart';

final period = [
  CItem(id: 0, value: '주기'),
  CItem(id: 1, value: '월차'),
  CItem(id: 2, value: '분기'),
  CItem(id: 3, value: '반기'),
  CItem(id: 4, value: '연차')
];

final ordinal = [
  CItem(id: 0, value: '차수'),
  CItem(id: 1, value: '1차'),
  CItem(id: 2, value: '2차'),
  CItem(id: 3, value: '3차'),
  CItem(id: 4, value: '4차')
];

class WriteScreen extends CWidget {
  WriteScreen({super.key});

  final c = Get.find<WriteController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    return Obx(() => CForm(padding: const EdgeInsets.all(10), children: [
          CRow(mainAxisAlignment: MainAxisAlignment.end, children: [
            CButton(
              width: 140,
              text: '기존 기록 불러오기',
              flex: 1,
              size: CButtonSize.small,
              type: CButtonStyle.outlined,
              onPressed: () => {},
            ),
          ]),
          CFormtitle(title: '점검대상'),
          CFormtext(c.customer,
              onTap: () => clickCustomer(), errText: c.errorCompany),
          CFormtitle(title: '점검주기'),
          CRow(gap: 10, children: [
            Expanded(
                child: CSelectbox(
                    items: period,
                    selected: c.period,
                    onSelected: (pos) {
                      c.period = pos;
                      c.name.text =
                          '${c.customer} ${c.date.month}월 ${period[c.period].value} ${ordinal[c.ordinal].value} 안전점검';
                    })),
            Expanded(
                child: CSelectbox(
                    items: ordinal,
                    selected: c.ordinal,
                    onSelected: (pos) {
                      c.ordinal = pos;
                      c.name.text =
                          '${c.customer} ${c.date.month}월 ${period[c.period].value} ${ordinal[c.ordinal].value} 안전점검';
                    }))
          ]),
          CFormtitle(title: '점검일시'),
          CRow(gap: 10, children: [
            Expanded(
              child: CFormtext(
                DateFormat('yyyy.MM.dd').format(c.date),
                onTap: () => clickDate(),
              ),
            ),
            Expanded(
              child: CFormtext(
                DateFormat('HH:mm').format(c.date),
                onTap: () => clickTime(),
              ),
            ),
          ]),
          CFormfield(
            title: '점검지명',
            controller: c.name,
            errText: c.errorTitle,
          ),
        ]));
  }

  bottom() {
    return CRow(padding: const EdgeInsets.only(bottom: 10), gap: 10, children: [
      CButton(
        text: '취소',
        flex: 1,
        size: CButtonSize.normal,
        type: CButtonStyle.outlined,
        onPressed: () => clickCancel(),
      ),
      CButton(
        text: '신규생성',
        flex: 1,
        size: CButtonSize.normal,
        onPressed: () => clickSave(),
      ),
    ]);
  }

  clickCancel() {
    Get.back();
  }

  clickSave() async {
    final ret = await c.insert();
    if (ret == false) {
      return;
    }

    Get.offAllNamed('/');
  }

  clickCustomer() {
    Get.dialog(
      barrierDismissible: true,
      AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: Get.width - 40,
            child: Obx(
              () => CColumn(
                gap: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
                children: [
                  const SizedBox(height: 0),
                  CRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        CText('점검대상 검색',
                            textStyle: const TextStyle(fontSize: 18)),
                        CContainer(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.close, color: Colors.black))
                      ]),
                  const SizedBox(height: 5),
                  CTextField(
                      svg: 'assets/imgs/search.svg',
                      maxLines: 1,
                      onChanged: (value) {
                        c.search = value;
                      }),
                  userlist()
                ],
              ),
            ),
          )),
    );
  }

  bool containsInitialConsonant(String string, String query) {
    /*
      Hangul UTF16 structure :
      ① Hangul characters start from 44032(== '가').
      ② A group of same initial consonant has 588 characters.
      ③ Initial consonants are 19ea,
        such as 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
      ④ Hangul initial consonant characters start from 12593 to 12622
        'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ',
    */
    const codeOfFirstHangulLetter = 44032;
    const numberOfSameInitialConsonant = 588;
    final initialConsonants = [
      'ㄱ',
      'ㄲ',
      'ㄴ',
      'ㄷ',
      'ㄸ',
      'ㄹ',
      'ㅁ',
      'ㅂ',
      'ㅃ',
      'ㅅ',
      'ㅆ',
      'ㅇ',
      'ㅈ',
      'ㅉ',
      'ㅊ',
      'ㅋ',
      'ㅌ',
      'ㅍ',
      'ㅎ'
    ];

    if (string.length < query.length) {
      return false;
    }

    if (query.isEmpty) return true;

    for (int i = 0; i < string.length - query.length + 1; i++) {
      bool contains = true;
      for (int j = 0; j < query.length; j++) {
        if (initialConsonants.contains(query.substring(j, j + 1))) {
          if ((string.substring(i + j, i + j + 1).codeUnitAt(0) -
                      codeOfFirstHangulLetter) ~/
                  numberOfSameInitialConsonant !=
              initialConsonants.indexOf(query.substring(j, j + 1))) {
            contains = false;
            break;
          }
        } else {
          if (query.substring(j, j + 1) != string.substring(i + j, i + j + 1)) {
            contains = false;
            break;
          }
        }
      }
      if (contains) return true;
    }
    return false;
  }

  userlist() {
    List<Widget> items = [];

    for (var i = 0; i < c.items.length; i++) {
      Building item = c.items[i];
      final name = item.name;

      if (c.search != '') {
        if (!name.contains(c.search)) {
          if (!containsInitialConsonant(name, c.search)) {
            continue;
          }
        }
      }

      items.add(CText(
        name,
        margin: const EdgeInsets.only(bottom: 10),
        onTap: () => clickSelectCustomer(item),
      ));
    }

    return CContainer(
        height: Get.height / 2,
        child: SingleChildScrollView(
            child: CRow(children: [
          Expanded(
              child: CColumn(
            children: items,
          ))
        ])));
  }

  clickSelectCustomer(Building item) {
    c.customer = item.name;
    c.customerid = item.company;
    c.buildingid = item.id;
    c.name.text =
        '${item.name} ${c.date.month}월 ${period[c.period].value} ${ordinal[c.ordinal].value} 안전점검';
    Get.back();
  }

  clickDate() async {
    final context = Get.context!;

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Center(
            child: CTableCalendar(
              focusedDay: c.date,
              events: const {},
              calendarFormat: CalendarFormat.month,
              getMonth: () {},
              onDaySelected: onDaySelected,
              onPageChanged: onPageChanged,
            ),
          ),
        );
      },
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final context = Get.context!;
    c.date = selectedDay;
    c.name.text =
        '${c.customer} ${c.date.month}월 ${period[c.period].value} ${ordinal[c.ordinal].value} 안전점검';
    Navigator.pop(context);
  }

  onPageChanged(DateTime focusedDay) async {}

  clickTime() async {
    final context = Get.context!;

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Center(
            child: CupertinoDatePicker(
              initialDateTime: c.date,
              mode: CupertinoDatePickerMode.time,
              minuteInterval: 5,
              // use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                c.date = newTime;
              },
            ),
          ),
        );
      },
    );
  }
}
