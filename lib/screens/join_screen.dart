import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';

class JoinScreen extends CWidget {
  JoinScreen({Key? key}) : super(key: key);

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
                disabled:
                    c.loginid.isEmpty || c.passwd.isEmpty || c.name.isEmpty,
                onPressed: () async {
                  var res = await c.join();
                  if (res != true) {
                    return;
                  }

                  Get.offAllNamed('/');
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
                    title: '비밀번호', onChanged: (value) => c.passwd = value),
                CFormfield(
                  title: '닉네임',
                  onChanged: (value) => c.name = value,
                  errText: c.nameError,
                ),
              ]),
            ]),
      ),
    );
  }
}
