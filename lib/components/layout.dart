import 'package:common_control/common_control.dart';
import 'package:zkeep/components/circle_navigation.dart';
import 'package:zkeep/components/head.dart';

class Layout extends CWidget {
  Layout({super.key, required this.child, this.popup = false, this.title = ''});

  final Widget child;
  final bool popup;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (popup == true) {
      return CScaffold(
          appBar: AppBar(
            title: Head(title: title),
            backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
            elevation: 0.0,
            automaticallyImplyLeading: true,
          ),
          autoLostFocus: true,
          body: Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: child));
    }

    return CScaffold(
        appBar: AppBar(
          title: Head(title: title),
          backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: child),
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () =>
                Get.toNamed('/write', arguments: {'mode': 'write'}),
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CircleNavigation());
  }
}
