import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/Cformtitle.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';

class MypageEditScreen extends CWidget {
  MypageEditScreen({super.key});

  final c = Get.find<MypageEditController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(bottom: bottom(), body: form());
  }

  form() {
    final emailAddress = [
      CItem(id: 0, value: 'myster.co.kr'),
      CItem(id: 1, value: 'naver.com'),
      CItem(id: 2, value: 'gmail.com'),
      CItem(id: 3, value: 'nate.net')
    ];

    return Obx(() => CForm(padding: const EdgeInsets.all(10), children: [
          CFormfield(
            title: '아이디',
            controller: c.loginid,
            errText: c.errorLoginid,
            onChanged: (value) => c.user.loginid = value,
          ),
          CFormfield(
            title: '비밀번호',
            controller: c.passwd,
            errText: c.errorPasswd,
            onChanged: (value) => c.user.passwd = value,
          ),
          CFormfield(
            title: '이름',
            controller: c.name,
            errText: c.errorName,
            onChanged: (value) => c.user.name = value,
          ),
          CFormfield(
            title: '휴대전화',
            controller: c.tel,
            errText: c.errorTel,
            onChanged: (value) => c.user.tel = value,
          ),
          CFormfield(
            title: '이메일',
            controller: c.email,
            errText: c.errorEmail,
            onChanged: (value) => c.user.email = value,
          ),
          // CFormtitle(title: '이메일'),
          // CRow(gap: 10, children: [
          //   Expanded(
          //     child: CFormtext(
          //       c.emailId,
          //       onTap: () => clickEmailId(),
          //     ),
          //   ),
          //   CText('@'),
          //   Expanded(
          //       child: CSelectbox(
          //           items: emailAddress,
          //           selected: c.emailAddress,
          //           onSelected: (pos) {
          //             c.emailAddress = pos;
          //           }))
          // ]),
          CFormtitle(title: '주소'),
          CColumn(gap: 10, children: [
            CFormfield(
              controller: c.address,
              onChanged: (value) => c.user.address = value,
            ),
            CFormfield(
              controller: c.addressetc,
              onChanged: (value) => c.user.addressetc = value,
            ),
            // CFormtext(
            //   c.addressStreet,
            //   onTap: () => clickAdressStreet(),
            // ),
            // CFormtext(
            //   c.addressEtc,
            //   onTap: () => clickAdressEtc(),
            // ),
          ]),
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
        text: '이력정보',
        flex: 1,
        size: CButtonSize.normal,
        onPressed: () => clickRecod(),
      ),
    ]);
  }

  clickEmailId() {}

  clickAdressStreet() {
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
                      CText('주소 검색', textStyle: const TextStyle(fontSize: 18)),
                      CContainer(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close, color: Colors.black))
                    ]),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clickAdressEtc() {}

  clickCancel() {
    Get.back();
  }

  clickRecod() async {
    Get.toNamed('/mypage/editrecod');
  }
}
