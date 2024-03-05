import 'package:common_control/common_control.dart';
import 'package:zkeep/components/circle_navigation.dart';
import 'package:zkeep/components/head.dart';

class Layout extends CWidget {
  Layout(
      {super.key,
      required this.child,
      this.popup = false,
      this.title = '',
      this.home = false});

  final Widget child;
  final bool popup;
  final String title;
  final bool home;

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    List<Widget>? actions;

    if (popup == true) {
      leading = IconButton(
          onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios));
      return CScaffold(
          appBar: AppBar(
            title: Head(title: title),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1.0,
            automaticallyImplyLeading: true,
            leading: leading,
            actions: actions,
          ),
          autoLostFocus: true,
          body: Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: child));
    }

    if (home == true) {
      leading = IconButton(
          onPressed: () => Get.offAllNamed('/'), icon: const Icon(Icons.home));
    }

    return CScaffold(
        appBar: AppBar(
            title: Head(title: title),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 1.0,
            automaticallyImplyLeading: true,
            leading: leading),
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
