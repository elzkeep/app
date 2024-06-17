import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cformtitle.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/ctablecalendar.dart';
import 'package:zkeep/components/layout.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_license_controller.dart';

final items =
    CItem.list(['', '전기기사', '전기공사기능사', '전기산업기사', '전기기능장', '전기기능사', '전기기사']);

final levels = CItem.list(['', '특급', '고급', '중급', '초급']);

class MypageEditRecodLicenseScreen extends CWidget {
  MypageEditRecodLicenseScreen({super.key});

  final c = Get.find<MypageEditLicenseController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    return Obx(() => CForm(padding: const EdgeInsets.all(10), children: [
          CFormtitle(title: '자격증 정보'),
          CRow(gap: 10, children: [
            Expanded(
                child: CSelectbox(
                    items: items,
                    selected: c.licensecategory,
                    onSelected: (pos) {
                      c.licensecategory = pos;
                    })),
            Expanded(
                child: CSelectbox(
                    items: levels,
                    selected: c.licenselevel,
                    onSelected: (pos) {
                      c.licenselevel = pos;
                    })),
          ]),
          CFormtext(
            DateFormat('yyyy.MM.dd').format(c.date),
            onTap: () => {
              clickDate(),
            },
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
      if (c.index != 0)
        CButton(
          text: '삭제',
          flex: 1,
          size: CButtonSize.normal,
          onPressed: () => clickDelete(),
        ),
      CButton(
        text: '저장',
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
    final ret = await c.save();
    if (ret == false) {
      return;
    }
    Get.back();
  }

  clickDelete() async {
    final ret = await c.delete();
    if (ret == false) {
      return;
    }
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
    Navigator.pop(context);
  }

  onPageChanged(DateTime focusedDay) async {}
}
