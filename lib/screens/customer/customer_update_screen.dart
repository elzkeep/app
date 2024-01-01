import 'package:common_control/common_control.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/controllers/customer/customer_update_controller.dart';

class CustomerUpdateScreen extends CWidget {
  CustomerUpdateScreen({super.key});

  final c = Get.find<CustomerUpdateController>();

  final textStyle = Style(textStyle: const TextStyle(fontSize: 14));

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    Widget widget = Container();

    if (c.index == 1) {
      widget = company();
    } else if (c.index == 2) {
      widget = building();
    } else if (c.index == 3) {
      widget = check();
    } else if (c.index == 4) {
      widget = contract();
    }

    return CScroll(gap: 20, children: [widget, const SizedBox(height: 50)]);
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
    /*
    final ret = await c.insert();
    if (ret == false) {
      return;
    }
      */

    Get.back();
  }

  company() {
    return CForm(children: [
      CFormfield(
          title: '사업자번호', text: c.companyno.text, controller: c.companyno),
      CFormfield(title: '고객명', text: c.name.text, controller: c.name),
      CFormfield(title: '대표자', text: c.ceo.text, controller: c.ceo),
      CFormfield(title: '주소', text: c.address.text, controller: c.address),
    ]);
  }

  building() {
    return CForm(children: [
      CFormfield(
          title: '시설명', text: c.buildingname.text, controller: c.buildingname),
      CFormfield(
          title: '사업자번호',
          text: c.buildingcompanyno.text,
          controller: c.buildingcompanyno),
      CFormfield(
          title: '대표자', text: c.buildingceo.text, controller: c.buildingceo),
      CFormfield(
          title: '주소',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
    ]);
  }

  check() {
    return CForm(children: [
      CFormfield(
          title: '점검분야',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '관리형태',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '점검일',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '점검예정일',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자 연락처',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자 이메일',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
    ]);
  }

  contract() {
    return CForm(children: [
      CFormfield(
          title: '계약기간',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '계약금액',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '청구방식',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '청구일',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자명',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자 연락처',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
      CFormfield(
          title: '담당자 이메일',
          text: c.buildingaddress.text,
          controller: c.buildingaddress),
    ]);
  }
}
