import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/dround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/customer/customer_box.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/models/report.dart';

class MypageScreen extends CWidget {
  MypageScreen({super.key});

  final c = Get.find<MypageController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: '마이페이지',
        child: CScroll(gap: 25, children: [
          myprofile(),
          record(),
          customer(),
          calendar(),
          lists(),
        ]));
  }

  myprofile() {
    const textStyle = TextStyle(fontSize: 12, color: Colors.black54);
    const nameStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return CRow(
      gap: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              '홍길동' ' 님',
              textStyle: nameStyle,
            ),
            CText(
              '010-9999-1111',
              textStyle: textStyle,
            ),
            CText(
              'hongpro@myster.co.kr',
              textStyle: textStyle,
            ),
          ],
        ),
        CText(
          '변경',
          style: Config.moreStyle,
          onTap: () => Get.toNamed('/mypage/edit'),
          margin: const EdgeInsets.symmetric(vertical: 10),
        )
      ],
    );
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
                      CText('(주)마이스터'),
                      CText('동부팀'),
                    ]),
                CBothSide(
                    gap: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.person_crop_rectangle,
                          color: Colors.black54),
                      const SizedBox(width: 10),
                      DRound(
                          backgroundColor: Colors.black54,
                          child: CText(
                            '전기기사(고급)',
                            textStyle: const TextStyle(
                                fontSize: 11, color: Colors.white),
                          )),
                      DRound(
                          backgroundColor: Colors.black54,
                          child: CText(
                            '소방전기기사(고급)',
                            textStyle: const TextStyle(
                                fontSize: 11, color: Colors.white),
                          )),
                    ]),
              ]))
    ]);
  }

  customer() {
    return CColumn(gap: 10, children: [
      SubTitle('고객관리',
          more: '더보기', onMore: () => Get.toNamed('/mypage/customer')),
      CustomerBox()
    ]);
  }

  calendar() {
    return CColumn(
      gap: 10,
      children: [
        SubTitle('일정관리'),
        Obx(
          () => TableCalendar(
            onFormatChanged: _onFormatChanged,
            onDaySelected: _onDaySelected,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: c.focusedDay,
            calendarFormat: c.calendarFormat,
            locale: 'ko_KR',
            daysOfWeekHeight: 30,
            rowHeight: 35,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week'
            },
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              disabledTextStyle: TextStyle(color: Color(0xFFBFBFBF)),
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  return CText(
                    '일',
                    alignment: Alignment.center,
                    textStyle: const TextStyle(color: Colors.red),
                  );
                }
                if (day.weekday == DateTime.saturday) {
                  return CText(
                    '토',
                    alignment: Alignment.center,
                    textStyle: const TextStyle(color: Colors.blue),
                  );
                }
                return null;
              },
              todayBuilder: (context, day, selectedDay) {
                return CContainer(
                  width: 40,
                  height: 40,
                  decoration: day == selectedDay
                      ? const BoxDecoration(
                          color: Config.primaryColor, shape: BoxShape.circle)
                      : null,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CContainer(
                        height: 36,
                        child: CText(
                          alignment: Alignment.center,
                          day.day.toString(),
                          textStyle: day == selectedDay
                              ? const TextStyle(color: Colors.white)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 22,
                        child: CText(
                          '오늘',
                          textStyle: day == selectedDay
                              ? const TextStyle(
                                  fontSize: 8, color: Colors.white)
                              : const TextStyle(fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                if (day == c.focusedDay) {
                  return CContainer(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Config.primaryColor, shape: BoxShape.circle),
                    child: CText(
                      alignment: Alignment.center,
                      day.day.toString(),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (day.weekday == DateTime.sunday) {
                  return CText(
                    alignment: Alignment.center,
                    day.day.toString(),
                    textStyle: const TextStyle(color: Colors.red),
                  );
                }
                if (day.weekday == DateTime.saturday) {
                  return CText(
                    alignment: Alignment.center,
                    day.day.toString(),
                    textStyle: const TextStyle(color: Colors.blue),
                  );
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    c.focusedDay = selectedDay;
    print(focusedDay);
  }

  void _onFormatChanged(CalendarFormat format) {
    c.calendarFormat = format;
  }

  lists() {
    return CContainer(
      height: 100,
      alignment: Alignment.topCenter,
      child: CText('아직 등록된 일정이 없어요'),
    );
    // if (cache.length == 0) {
    //   return CContainer(
    //     height: 100,
    //     alignment: Alignment.topCenter,
    //     child: CText('아직 등록된 일정이 없어요'),
    //   );
    // }
    // return Obx(
    //   () => ListView.builder(
    //     itemCount: cache.length,
    //     itemBuilder: (context, index) {
    //       return list(cache[index], index);
    //     },
    //   ),
    // );
  }

  Widget list(Report item, int index) {
    return CColumn(
      children: [
        CRow(
          children: [
            CContainer(
                margin: const EdgeInsets.only(top: 4),
                backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
                width: 5,
                height: 14,
                child: Container()),
            const SizedBox(width: 8),
            SubTitle('10:00'),
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
              CText(item.title),
              CRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(item.company.name,
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                    CText('|',
                        textStyle: const TextStyle(
                            color: Colors.black54, fontSize: 12)),
                    CText('1',
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
