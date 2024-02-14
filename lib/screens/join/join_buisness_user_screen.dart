import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';

class JoinBuisnessUserScreen extends CWidget {
  JoinBuisnessUserScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      autoLostFocus: true,
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Get.back();
            }),
      ),

      /*action: "assets/imgs/icon_x_mark.svg",*/
      body: Obx(
        () => CFixedBottom(
            bottom: CButton(
                padding: const EdgeInsets.all(20),
                text: '회원 가입',
                disabled: c.loginid.isEmpty ||
                    c.passwd.isEmpty ||
                    c.passwdtwo.isEmpty ||
                    c.name.isEmpty ||
                    c.businessnum.isEmpty ||
                    c.building.isEmpty ||
                    c.phonenum.isEmpty,
                onPressed: () async {
                  var res = await c.join();
                  if (res != true) {
                    return;
                  }

                  Get.offAllNamed('/join/user/detail');
                },
                size: CButtonSize.large,
                margin: const EdgeInsets.only(top: 24, bottom: 0)),
            children: [
              CForm(padding: const EdgeInsets.all(20), children: [
                CFormfield(
                  title: '아이디',
                  onChanged: (value) => c.loginid = value,
                  errText: c.loginidError,
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
                  title: '사업자번호',
                  onChanged: (value) => c.businessnum = value,
                  errText: c.businessnumError,
                ),
                CFormfield(
                  title: '이름',
                  onChanged: (value) => c.name = value,
                  errText: c.nameError,
                ),
                CFormfield(
                  title: '건물 이름',
                  onChanged: (value) => c.building = value,
                  errText: c.buildingError,
                ),
                CFormfield(
                  title: '휴대폰번호',
                  onChanged: (value) => c.phonenum = value,
                ),
              ]),
            ]),
      ),
    );
  }
}
