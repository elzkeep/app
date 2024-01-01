import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigation extends CWidget {
  BottomNavigation({Key? key}) : super(key: key);

  Widget naviButton(
      {required bool selected,
      required String text,
      required VoidCallback onPressed}) {
    return IconButton(
        icon: CSvg(text, color: Colors.black45),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      /*
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0.0,
      */
                child: CContainer(
                    padding: const EdgeInsets.all(0),
                    child: CRow(
                        padding: const EdgeInsets.only(top: 5),
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.home, color: Colors.black54),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => Get.offAndToNamed('/')
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.doc_plaintext, color: Colors.black54),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => Get.offAndToNamed('/data')
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.person_2_square_stack, color: Colors.black54),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => Get.offAndToNamed('/customer')
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.person_crop_circle, color: Colors.black54),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () => Get.offAndToNamed('/mypage')
                          ),
                        ])));
  }
}
