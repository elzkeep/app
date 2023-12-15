import 'package:common_control/common_control.dart';

class Head extends CWidget {
  Head({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    if (title == '') {
      return CRow(
          mainAxisAlignment: MainAxisAlignment.center,
          gap: 5,
          children: [
            const Text('지킴',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            CSvg('assets/imgs/logo.svg', height: 20)
          ]);
    }

    return CRow(mainAxisAlignment: MainAxisAlignment.center, gap: 5, children: [
      Text(title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
    ]);
  }
}
