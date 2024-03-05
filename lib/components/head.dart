import 'package:common_control/common_control.dart';

class Head extends CWidget {
  Head({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    if (title == '') {
      return CRow(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          gap: 5,
          children: [
            const Text('지킴',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Image.asset('assets/imgs/nlogo.png', height: 20)
            //CSvg('assets/imgs/logo.svg', height: 20)
          ]);
    }

    return Text(title,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold));
  }
}
