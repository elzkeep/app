import 'package:zkeep/controllers/login_controller.dart';
import 'package:common_control/common_control.dart';

class LoginScreen extends CWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      autoLostFocus: true,
      appBar: AppBar(
        /*title: const Text('로그인'),*/
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      /*action: "assets/imgs/icon_x_mark.svg",*/
      body: Obx(() => CColumn(padding: const EdgeInsets.only(top: 10, bottom: 10, left:20, right: 20), children: [
            CColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                expanded: true,
                gap: 8,
                children: [
                  CTextField(
                      onChanged: (value) => c.loginid = value,
                      svg: "assets/imgs/icon_login_textfield.svg",
                      text: '아이디'),
                  CTextField(
                      maxLines: 1,
                      obscure: true,
                      onChanged: (value) => c.passwd = value,
                      svg: "assets/imgs/icon_passwd_textfield.svg",
                      text: '비밀번호',
                      errText: c.message),
                  CButton(
                      text: '로그인',
                      disabled: c.loginid.isEmpty || c.passwd.isEmpty,
                      onPressed: () async {
                        var res = await c.login();
                        if (res != true) {
                          return;
                        }

                        Get.offAllNamed('/');
                      },
                      size: CButtonSize.large,
                      margin: const EdgeInsets.only(top: 14, bottom: 0)),
                  CButton(
                      text: '회원가입',
                      onPressed: () async {
                        Get.toNamed('/join');
                      },
                      size: CButtonSize.large,
                      type: CButtonStyle.outlined,
                      margin: const EdgeInsets.only(top: 0, bottom: 0)),
                ])
          ])),
      /*
        bottomNavigationBar: BottomAppBar(
            child: CButton(
                text: "회원가입",
                size: CButtonSize.large,
                type: CButtonStyle.outlined,
                onPressed: () => Get.toNamed('/signup'),
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 24)))*/
    );
  }
}
