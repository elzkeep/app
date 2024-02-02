import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';

class MypageEditRecodScreen extends CWidget {
  MypageEditRecodScreen({super.key});

  final c = Get.find<MypageEditController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    return CColumn(gap: 10, padding: const EdgeInsets.all(10), children: [
      SubTitle('소속 정보'),
      Obx(() => CForm(children: [
            CFormfield(
              title: '소속회사',
              controller: c.company,
              errText: c.errorCompany,
            ),
            CFormfield(
              title: '입사일',
              controller: c.joinDate,
              errText: c.errorJoinDate,
            ),
            CFormfield(
              title: '경력',
              controller: c.career,
              errText: c.errorCareer,
            ),
          ])),
      SubTitle('자격 정보',
          more: '불러오기', onMore: () => Get.toNamed('/mypage/customer')),
      CRow(gap: 20, children: [
        Expanded(
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
                    border: Border.all(
                      color: const Color(0xffE0E0E0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                width: 89,
                height: 64,
                child: CText(
                  '전기기사',
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              CText('2016.01.04', textStyle: const TextStyle(fontSize: 12)),
              CText('기술등급: 고급', textStyle: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Expanded(
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
                    border: Border.all(
                      color: const Color(0xffE0E0E0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                width: 89,
                height: 64,
                child: CText(
                  '전기공사기사',
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              CText('2010.04.05', textStyle: const TextStyle(fontSize: 12)),
              CText('기술등급: 특급', textStyle: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: CRound(
            backgroundColor: const Color(0x003b457b),
            child: CText('전기'),
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
    final ret = await c.insert();
    if (ret == false) {
      return;
    }

    Get.offAllNamed('/');
  }
}
