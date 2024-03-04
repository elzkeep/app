import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';

class CircleNavigationController extends GetxController {
  final _index = 0.obs;

  int get index => _index.value;
  set index(int value) => _index.value = value;
}

class CircleNavigation extends CWidget {
  CircleNavigation({super.key});

  final c = Get.find<CircleNavigationController>();

  @override
  build(BuildContext context) {
    return Obx(() => AnimatedBottomNavigationBar(
          height: 70,
          iconSize: 30,
          icons: const [
            CupertinoIcons.home,
            CupertinoIcons.doc_plaintext,
            CupertinoIcons.person_2_square_stack,
            CupertinoIcons.person_crop_circle,
          ],
          activeIndex: c.index,
          activeColor: Colors.black87,
          inactiveColor: Colors.black45,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) {
            c.index = index;
            if (index == 0) {
              Get.offAndToNamed('/');
            } else if (index == 1) {
              Get.offAndToNamed('/data');
            } else if (index == 2) {
              Get.offAndToNamed('/customer');
            } else if (index == 3) {
              Get.offAndToNamed('/mypage');
            }
          },
        ));
  }
}
