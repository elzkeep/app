import 'package:common_control/common_control.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/main_title.dart';
import 'package:zkeep/controllers/mypage/customer/insert_controller.dart';

class InsertScreen extends CWidget {
  InsertScreen({super.key});

  final c = Get.find<InsertController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    return Obx(() => CForm(children: [
        MainTitle('고객 정보'),
          CFormfield(title: '사업자 등록증', controller: c.companyNo, errText: c.errorCompanyNo, onChanged: (value) {
              if (c.companyNo.text != '') {
                c.errorCompanyNo = '';
              }
          }),
          CFormfield(title: '고객명', controller: c.name, errText: c.errorName, onChanged: (value) {
              if (c.name.text != '') {
                c.errorName = '';
              }
          }),
          CFormfield(title: '대표자', controller: c.ceo, errText: c.errorCeo, onChanged: (value) {
              if (c.ceo.text != '') {
                c.errorCeo = '';
              }
          }),
          CFormfield(title: '주소', controller:c.address, errText: c.errorAddress),
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
        text: '등록',
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
    print('click insert');
    if (!await c.insert()) {
      return;
    }
    Get.back();
  }
}
