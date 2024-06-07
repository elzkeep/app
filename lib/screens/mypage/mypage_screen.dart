import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/ctablecalendar.dart';
import 'package:zkeep/components/dround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/customer/customer_box.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/auth_controller.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/models/reportstatusextension.dart';

class Event {
  String title;

  Event(this.title);
}

class MypageScreen extends CWidget {
  MypageScreen({super.key});

  final c = Get.find<MypageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Layout(
        title: '마이페이지',
        child: CScroll(gap: 25, children: [
          myprofile(),
          record(),
          customer(),
          calendar(),
          lists(),
          const SizedBox(height: 50),
        ])));
  }

  myprofile() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.black54);
    const nameStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return CRow(
      gap: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CRow(
          gap: 15,
          children: [
            CContainer(
              width: 76,
              height: 76,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CContainer(
                  backgroundColor: Colors.blue,
                  // CSvg('assets/imgs/corner-up-right.svg'),
                ),
              ),
            ),
            CColumn(
              margin: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CText(
                  '${c.user['name']} 님',
                  textStyle: nameStyle,
                ),
                CText(
                  c.user['tel'],
                  textStyle: textStyle,
                ),
                CText(
                  c.user['email'],
                  textStyle: textStyle,
                ),
              ],
            ),
          ],
        ),
        CColumn(children: [
          CText(
            '변경',
            style: Config.moreStyle,
            onTap: () => Get.toNamed('/mypage/edit'),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          CText(
            '로그아웃',
            style: Config.moreStyle,
            onTap: () => logout(),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ]),
      ],
    );
  }

  logout() {
    AuthController().logout();
    Get.offAndToNamed('/login');
  }

  record() {
    return CColumn(gap: 10, children: [
      SubTitle('이력관리'),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 20,
              children: [
                CBothSide(
                    gap: 30,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.building_2_fill,
                          color: Colors.black54),
                      // CText('(주)마이스터'),
                      // CText('동부팀'),
                      CText(c.company.name),
                      CText(c.department.name),
                    ]),
                CRow(
                  children: [
                    const Icon(CupertinoIcons.person_crop_rectangle,
                        color: Colors.black54),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: 4,
                        children: [
                          for (var li in c.license)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: DRound(
                                  backgroundColor: Colors.black54,
                                  child: CText(
                                    '${li.extra['licensecategory']['name']}(${li.extra['licenselevel']['name']})',
                                    textStyle: const TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  )),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]))
    ]);
  }

  customer() {
    return CColumn(gap: 10, children: [
      SubTitle('고객관리', more: '더보기', onMore: () => Get.offAllNamed('/customer')),
      CustomerBox(total: c.customerTotal, score: c.score.toStringAsFixed(1))
    ]);
  }

  calendar() {
    return CColumn(
      gap: 10,
      children: [
        SubTitle('일정관리'),
        Obx(
          () => CTableCalendar(
            focusedDay: c.focusedDay,
            events: c.events,
            calendarFormat: c.calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week'
            },
            getMonth: c.getMonth,
            onFormatChanged: onFormatChanged,
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
          ),
        ),
      ],
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (selectedDay.month != c.focusedDay.month) {
      await c.getMonth(selectedDay);
    }
    c.focusedDay = selectedDay;
    c.find(selectedDay);
  }

  void onPageChanged(DateTime focusedDay) async {
    if (focusedDay.month != c.focusedDay.month) {
      await c.getMonth(focusedDay);
    }
    c.focusedDay = focusedDay;
    c.find(focusedDay);
  }

  void onFormatChanged(CalendarFormat format) {
    c.calendarFormat = format;
  }

  lists() {
    if (c.items.isEmpty) {
      return CContainer(
        height: 100,
        alignment: Alignment.topCenter,
        child: CText('아직 등록된 일정이 없어요'),
      );
    }
    return Obx(
      () => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: c.items.length,
        itemBuilder: (context, index) {
          return list(c.items[index], index);
        },
      ),
    );
  }

  Widget list(Report item, int index) {
    return CColumn(
      children: [
        CRow(
          children: [
            CContainer(
                margin: const EdgeInsets.only(top: 4),
                backgroundColor: Config.primaryColor,
                width: 5,
                height: 14,
                child: Container()),
            const SizedBox(width: 8),
            SubTitle(item.checktime),
          ],
        ),
        CContainer(
          onTap: () =>
              Get.toNamed('/data/${item.id}', arguments: {'item': item}),
          decoration: BoxDecoration(
              color: const Color(0xffE0E0E0),
              border: Border.all(
                color: const Color(0xffE0E0E0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(width: 10),
            Expanded(
                child: CColumn(gap: 10, children: [
              CRow(gap: 5, children: [
                Expanded(
                  child: CText(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DRound(
                    backgroundColor: item.status.color,
                    child: CText(
                      item.status.name,
                      textStyle:
                          const TextStyle(fontSize: 11, color: Colors.white),
                    )),
              ]),
              CRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(item.company.name,
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                    CText('|',
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                    CText(
                        '${DateFormat('MM월 dd일').format(DateTime.parse(item.checkdate))} ${item.checktime}',
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 12))
                  ]),
            ])),
            const SizedBox(width: 20),
            CRow(
              margin: const EdgeInsets.all(10),
              gap: 10,
              children: [
                CSvg('assets/imgs/corner-up-right.svg'),
                CSvg('assets/imgs/call.svg'),
                CSvg('assets/imgs/message.svg'),
              ],
            )
          ]),
        ),
      ],
    );
  }
}
