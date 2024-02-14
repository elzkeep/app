import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';

class JoinUserDetailScreen extends CWidget {
  JoinUserDetailScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    final items = CItem.list(['전기공사기능사', '전기기능사', '전기기사', '전기산업기사', '전기응용기술사']);

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
                disabled: c.email.isEmpty,
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
                  title: '이메일',
                  onChanged: (value) => c.email = value,
                  errText: c.emailError,
                ),
                CText('점검기술자격증'),
                CSelectbox(
                  items: items,
                  selected: c.certificate,
                  onSelected: (pos) => c.certificate = pos,
                ),
                const SizedBox(
                  height: 10,
                ),
                CContainer(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE0E0E0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  width: double.infinity,
                  height: 200,
                  child: const Icon(Icons.add),
                )
              ]),
            ]),
      ),
    );
  }
}
