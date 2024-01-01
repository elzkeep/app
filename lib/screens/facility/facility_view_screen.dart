import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_view_controller.dart';

class FacilityViewScreen extends CWidget {
  FacilityViewScreen({super.key});

  final c = Get.find<FacilityViewController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
        popup: true,
        child: CScroll(gap: 20, children: [
          company(),
          building(),
          check(),
          contract(),
          contract2(),
          const SizedBox(height: 50)
        ]));
  }

  company() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '설비 기본 정보',
        more: '정보 수정',
        onMore: () => clickUpdate(1),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CBothSide(children: [CText('수전용량:'), CText('관리점수:')]),
                CBothSide(children: [CText('수전 위치:'), CText('수전 형태:')]),
              ]))
    ]);
  }

  building() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '수배전 설비',
        more: '수정',
        onMore: () => clickUpdate(2),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('수전전압: '),
                CBothSide(children: [CText('형태:'), CText('면수:')]),
              ]))
    ]);
  }

  check() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '고압차단기',
        more: '수정',
        onMore: () => clickUpdate(3),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('형식: '),
                CBothSide(children: [CText('정격전압:'), CText('정격전류:')]),
                CBothSide(children: [CText('차단전류:'), CText('차단용량:')]),
                CBothSide(children: [CText('제조사:'), CText('설치년월:')]),
              ]))
    ]);
  }

  contract() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '변압 설비',
        more: '수정',
        onMore: () => clickUpdate(4),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('변압기:'),
                CBothSide(children: [CText('공급방식:'), CText('형식:')]),
                CBothSide(children: [CText('정격용량:'), CText('1차 전류:')]),
                CBothSide(children: [CText('%Z수치:'), CText('2차 전류:')]),
                CBothSide(children: [CText('제조사:'), CText('설치연도:')]),
              ]))
    ]);
  }

  contract2() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '발전 설비',
        more: '수정',
        onMore: () => clickUpdate(4),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CBothSide(children: [CText('비상용발전:'), CText('발전용량:')]),
                CBothSide(children: [CText('태양광발전:'), CText('발전용량:')]),
              ]))
    ]);
  }

  clickUpdate(pos) {
    Get.toNamed('/facility/${c.id}/insert');
  }
}
