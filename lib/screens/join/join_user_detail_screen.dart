import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';

class JoinUserDetailScreen extends CWidget {
  JoinUserDetailScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    final items =
        CItem.list(['', '전기기사', '전기공사기능사', '전기산업기사', '전기기능장', '전기기능사', '전기기사']);

    final levels = CItem.list(['', '특급', '고급', '중급', '초급']);

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
            }),
      ),

      /*action: "assets/imgs/icon_x_mark.svg",*/
      body: Obx(
        () => CFixedBottom(
            bottom: CButton(
                padding: const EdgeInsets.all(20),
                text: '회원 가입',
                // disabled: c.email.isEmpty,
                onPressed: () async {
                  var res = await c.join();
                  if (res != true) {
                    return;
                  }
                  Get.offAllNamed('/login');
                },
                size: CButtonSize.large,
                margin: const EdgeInsets.only(top: 24, bottom: 0)),
            children: [
              CForm(padding: const EdgeInsets.all(20), children: [
                CText('점검기술자격증'),
                CSelectbox(
                  title: '자격증1',
                  items: items,
                  selected: c.certificate,
                  onSelected: (pos) => c.certificate = pos,
                ),
                CSelectbox(
                  items: levels,
                  selected: c.level,
                  onSelected: (pos) => c.level = pos,
                ),
                const SizedBox(
                  height: 10,
                ),
                CSelectbox(
                  title: '자격증2',
                  items: items,
                  selected: c.certificate1,
                  onSelected: (pos) => c.certificate1 = pos,
                ),
                CSelectbox(
                  items: levels,
                  selected: c.level1,
                  onSelected: (pos) => c.level1 = pos,
                ),
                const SizedBox(
                  height: 10,
                ),
                CSelectbox(
                  title: '자격증3',
                  items: items,
                  selected: c.certificate2,
                  onSelected: (pos) => c.certificate2 = pos,
                ),
                CSelectbox(
                  items: levels,
                  selected: c.level2,
                  onSelected: (pos) => c.level2 = pos,
                ),
                // CContainer(
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: const Color(0xffE0E0E0),
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.circular(8)),
                //   width: double.infinity,
                //   height: 200,
                //   child: const Icon(Icons.add),
                // )
              ]),
            ]),
      ),
    );
  }
}
