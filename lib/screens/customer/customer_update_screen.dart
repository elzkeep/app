import 'package:common_control/common_control.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cformtitle.dart';
import 'package:zkeep/components/ctablecalendar.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/controllers/customer/customer_update_controller.dart';
import 'package:zkeep/components/mapView/mapView.dart' as MapV;

bool get isWeb => identical(0, 0.0);

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
    bool ret = false;
    if (c.index == 1) {
      ret = await c.companySave();
    }
    if (c.index == 2) {
      ret = await c.buildingSave();
    }
    if (c.index == 3) {
      ret = await c.facilitySave();
    }
    if (c.index == 4) {
      ret = await c.billingSave();
    }

    if (ret == false) {
      return;
    }

    Get.back();
  }

  company() {
    return CForm(children: [
      CFormfield(
          title: '사업자번호',
          text: c.companycompanyno.text,
          controller: c.companycompanyno),
      CFormfield(
          title: '고객명', text: c.companyname.text, controller: c.companyname),
      CFormfield(
          title: '대표자', text: c.companyceo.text, controller: c.companyceo),
      CFormtitle(title: '주소'),
      Obx(() => CFormtext(c.companyaddress, onTap: () => searchAddress())),
      CFormfield(
          // title: '상세주소',
          text: c.companyaddressetc.text,
          controller: c.companyaddressetc),
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
      CFormtitle(title: '주소'),
      Obx(() => CFormtext(c.buildingaddress, onTap: () => searchAddress())),
      CFormfield(
          text: c.buildingaddressetc.text, controller: c.buildingaddressetc),
    ]);
  }

  check() {
    return CForm(children: [
      // CFormfield(title: '점검분야', text: c.address.text, controller: c.address),
      // CFormfield(title: '관리형태', text: c.address.text, controller: c.address),
      CFormfield(title: '점검일', text: c.checkdate.text, controller: c.checkdate),
      CFormfield(
          title: '점검예정일', text: c.contractday.text, controller: c.contractday),
      CFormfield(
          title: '담당자', text: c.managername.text, controller: c.managername),
      CFormfield(
          title: '담당자 연락처', text: c.managertel.text, controller: c.managertel),
      CFormfield(
          title: '담당자 이메일',
          text: c.manageremail.text,
          controller: c.manageremail),
    ]);
  }

  contract() {
    return Obx(() => CForm(children: [
          CFormtitle(title: '계약기간'),
          CRow(gap: 10, children: [
            Expanded(
              child: CFormtext(
                DateFormat('yyyy.MM.dd').format(c.contractstartdate),
                onTap: () => {
                  c.startday = true,
                  clickDate(c.contractstartdate),
                },
              ),
            ),
            Expanded(
              child: CFormtext(
                DateFormat('yyyy.MM.dd').format(c.contractenddate),
                onTap: () => {
                  c.startday = false,
                  clickDate(c.contractenddate),
                },
              ),
            ),
          ]),
          CFormfield(
              type: CTextFieldType.number,
              title: '계약금액',
              text: c.contractprice.text,
              controller: c.contractprice),
          // CFormfield(title: '청구방식', text: c.address.text, controller: c.address),
          CFormfield(
              type: CTextFieldType.number,
              title: '청구일',
              text: c.billingdate.text,
              controller: c.billingdate),
          CFormfield(
              title: '담당자명',
              text: c.billingname.text,
              controller: c.billingname),
          CFormfield(
              title: '담당자 연락처',
              text: c.billingtel.text,
              controller: c.billingtel),
          CFormfield(
              title: '담당자 이메일',
              text: c.billingemail.text,
              controller: c.billingemail),
        ]));
  }

  clickDate(date) async {
    final context = Get.context!;

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Center(
            child: CTableCalendar(
              focusedDay: date,
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
    print(c.startday);
    final context = Get.context!;
    print(c.startday);
    focusedDay = selectedDay;
    print(c.startday);
    if (c.startday == true) {
      c.contractstartdate = focusedDay;
      print("aaaa");
    } else {
      c.contractenddate = focusedDay;
      print("bbbb");
    }
    Navigator.pop(context);
  }

  onPageChanged(DateTime focusedDay) async {}

  void searchAddress() async {
    if (kIsWeb) {
      KopoModel? result = await Get.to(() => MapV.MapView(), routeName: '/k');

      c.companyaddress = result?.address ?? '';
      c.buildingaddress = result?.address ?? '';
    } else {
      KopoModel? model = await Get.to(() => RemediKopo());

      c.companyaddress = model?.address ?? '';
      c.buildingaddress = model?.address ?? '';
    }
  }
}
