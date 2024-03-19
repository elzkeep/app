import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zkeep/components/cselectbutton.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/list_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/report.dart';

class ListScreen extends CWidget {
  ListScreen({super.key});

  final c = Get.find<ListController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: '점검 데이터',
        child:
            CColumn(children: [search(), buttons(), Expanded(child: lists())]));
  }

  search() {
    return CTextField(
      text: '고객명, 점검일자, 점검지역',
      svg: 'assets/imgs/search.svg',
      margin: const EdgeInsets.only(top: 10),
      controller: c.searchTextController,
      onChanged: (value) async {
        c.searchText = c.searchTextController.text;
        c.search();
      },
    );
    //return CTextField(con: const Icon(Icons.search));
  }

  buttons() {
    return CRow(gap: 10, children: [
      Container(
          margin: const EdgeInsets.only(top: 10),
          child: OutlinedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 1.0, color: Colors.black54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
              child: CRow(gap: 3, children: [
                CSvg('assets/imgs/filter.svg', width: 14),
                const Text(
                  '필터',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ]))),
      searchbutton()
    ]);
  }

  searchbutton() {
    return Obx(() => Container(
        margin: const EdgeInsets.only(top: 10),
        child: CSelectButton(
            items: const ['빠른순서', '가까운 순', '신규', '점검완료'],
            index: c.searchIndex,
            onSelected: (index) => clickSearch(index))));
  }

  box(title) {
    return Expanded(
        child: roundBorder(
            CColumn(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CText(title, margin: const EdgeInsets.only(left: 10)),
      CRow(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText('52',
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            CText('/', textStyle: const TextStyle(fontSize: 18)),
            CText('60', textStyle: const TextStyle(fontSize: 18)),
          ]),
      CText('86%',
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          textAlign: TextAlign.right,
          textStyle: const TextStyle(fontSize: 12, color: Colors.black38)),
      LinearPercentIndicator(
        lineHeight: 7.0,
        percent: 0.5,
        backgroundColor: Colors.grey,
        progressColor: Config.primaryColor,
      )
    ])));
  }

  roundBorder(child) {
    return CContainer(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE0E0E0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: child);
  }

  lists() {
    return InfiniteScroll<Report>(
      margin: const EdgeInsets.only(top: 10),
      axis: Axis.vertical,
      controller: c,
      builder: list,
      empty: Container(),
    );
  }

  Widget list(Report item, int index) {
    return CContainer(
      onTap: () => Get.toNamed('/data/${item.id}', arguments: {
        'item': item,
        'building': Building.fromJson(item.extra['building'])
      }),
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
        CContainer(
            margin: const EdgeInsets.only(top: 4),
            backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
            width: 5,
            height: 14,
            child: Container()),
        const SizedBox(width: 10),
        Expanded(
            child: CColumn(gap: 10, children: [
          CText(item.title),
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText(item.company.name,
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText('|',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText(
                '${DateFormat('MM월 dd일').format(DateTime.parse(item.checkdate))} ${item.checktime}',
                textStyle: const TextStyle(color: Colors.black54, fontSize: 12))
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
    );
  }

  clickSearch(index) async {
    c.searchIndex = index;
    await c.search();
  }
}
