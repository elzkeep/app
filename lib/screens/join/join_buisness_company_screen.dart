import 'package:flutter/foundation.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cformtitle.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/components/mapView/mapView.dart' as MapV;

class JoinBuisnessCompanyScreen extends CWidget {
  JoinBuisnessCompanyScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      autoLostFocus: true,
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Get.back();
              c.address = '';
            }),
      ),
      body: Obx(
        () => CFixedBottom(
            bottom: CButton(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                text: '회원 가입',
                disabled: c.loginid.isEmpty ||
                    c.email.isEmpty ||
                    c.passwd.isEmpty ||
                    c.passwdtwo.isEmpty ||
                    c.name.isEmpty ||
                    c.businessnum.isEmpty ||
                    c.tel.isEmpty ||
                    (c.passwd != c.passwdtwo) ||
                    c.addressetc.isEmpty,
                onPressed: () async {
                  Get.toNamed('/join/buisness/company/detail');
                },
                size: CButtonSize.large,
                margin: const EdgeInsets.only(top: 5, bottom: 0)),
            children: [
              CForm(padding: const EdgeInsets.all(20), children: [
                CFormfield(
                  title: '아이디',
                  onChanged: (value) => c.loginid = value,
                  errText: c.loginidError,
                ),
                CFormfield(
                  title: '이메일',
                  onChanged: (value) => c.email = value,
                  errText: c.emailError,
                ),
                CFormfield(
                  title: '비밀번호',
                  onChanged: (value) => c.passwd = value,
                  errText: c.passwdError,
                ),
                CFormfield(
                  title: '비밀번호 확인',
                  onChanged: (value) => c.passwdtwo = value,
                  errText: c.passwdtwoError,
                ),
                CFormfield(
                  title: '이름',
                  onChanged: (value) => c.name = value,
                  errText: c.nameError,
                ),
                CFormfield(
                  title: '사업자번호',
                  onChanged: (value) => c.businessnum = value,
                  errText: c.businessnumError,
                ),
                CFormfield(
                  title: '휴대폰번호',
                  onChanged: (value) => c.tel = value,
                ),
                CFormtitle(title: '주소'),
                CFormtext(c.address, onTap: () => searchAddress()),
                CFormfield(
                  onChanged: (value) => c.addressetc = value,
                ),
              ]),
            ]),
      ),
    );
  }

  void searchAddress() async {
    if (kIsWeb) {
      KopoModel? result = await Get.to(() => MapV.MapView(), routeName: '/k');

      c.zip = result?.zonecode ?? '';
      c.address = result?.address ?? '';
    } else {
      KopoModel? model = await Get.to(() => RemediKopo());

      c.zip = model?.zonecode ?? '';
      c.address = model?.address ?? '';
    }
  }
}
