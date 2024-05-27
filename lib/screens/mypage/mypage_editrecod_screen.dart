import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cformtitle.dart';
import 'package:zkeep/components/ctablecalendar.dart';
import 'package:zkeep/components/layout.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';
import 'package:zkeep/models/company.dart';

class MypageEditRecodScreen extends CWidget {
  MypageEditRecodScreen({super.key});

  final c = Get.find<MypageEditController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: Obx(() => form()));
  }

  form() {
    return CScroll(gap: 10, padding: const EdgeInsets.all(10), children: [
      SubTitle('소속 정보'),
      CForm(children: [
        CFormtitle(title: '회사선택'),
        CFormtext(c.company.name, onTap: () => clickCompany()),
        CFormtitle(title: '입사일'),
        CFormtext(
          DateFormat('yyyy.MM.dd').format(c.date),
          onTap: () => clickDate(),
        ),
        CFormtitle(title: '경력'),
        CRow(gap: 10, children: [
          Expanded(
            child: CFormfield(
              text: '연',
              controller: c.careeryear,
              errText: c.errorCareer,
            ),
          ),
          Expanded(
            child: CFormfield(
              text: '월',
              controller: c.careermonth,
              errText: c.errorCareer,
            ),
          ),
        ]),
      ]),
      // SubTitle('자격 정보',
      //     more: '불러오기', onMore: () => Get.toNamed('/mypage/customer')),
      SubTitle('자격 정보'),
      CRow(gap: 20, children: [
        for (int i = 0; i < c.licenses.length; i++)
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed('mypage/editrecod/license', arguments: {
                'index': c.licenses[i].id,
                'license': c.licenses[i]
              }),
              child: CColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CContainer(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(92, 107, 192, 1.000),
                              Color.fromRGBO(59, 69, 123, 1.000)
                            ]),
                        borderRadius: BorderRadius.circular(8)),
                    width: 89,
                    height: 64,
                    child: CText(
                      c.licenses[i].extra['licensecategory']['name'] ?? '',
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CText(
                      DateFormat('yyyy.MM.dd')
                          .format(DateTime.parse(c.licenses[i].date)),
                      textStyle: const TextStyle(fontSize: 12)),
                  CText('기술등급: ${c.licenses[i].extra['licenselevel']['name']}',
                      textStyle: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        for (int i = 0; i < 3 - c.licenses.length; i++)
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed('mypage/editrecod/license',
                  arguments: {'index': 0}),
              child: CContainer(
                alignment: Alignment.center,
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                    color: Config.buttonColor, shape: BoxShape.circle),
                child: CText(
                  alignment: Alignment.center,
                  '+',
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
      ])
    ]);
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

    Get.offAllNamed('/mypage');
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

  clickCompany() {
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
                        CText('회사 검색',
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
                  companylist()
                ],
              ),
            ),
          )),
    );
  }

  companylist() {
    List<Widget> items = [];

    for (var i = 0; i < c.items.length; i++) {
      Company item = c.items[i];
      final name = item.name;
      final companyno = item.companyno;
      final address = '${item.address} ${item.addressetc}';

      if (c.search != '') {
        if (!name.contains(c.search)) {
          if (!containsInitialConsonant(name, c.search)) {
            continue;
          }
        }
      }

      items.add(CColumn(
          margin: const EdgeInsets.only(bottom: 10),
          onTap: () => clickSelectCustomer(item),
          children: [
            CText(
              name,
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff212121)),
            ),
            CRow(children: [
              CText(
                '사업자번호 ',
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ),
              CText(
                companyno,
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ]),
            CRow(children: [
              CText(
                '주소 ',
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ),
              CText(
                address,
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ]),
          ]));
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

  clickSelectCustomer(Company item) {
    c.company = item;
    Get.back();
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
}
