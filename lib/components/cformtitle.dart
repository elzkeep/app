import 'package:common_control/common_control.dart';

class CFormtitle extends CWidget {
  CFormtitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = Style(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff212121)),
      margin: const EdgeInsets.only(top: 16,),
    );

    return CText(title, style: textStyle);
  }
}
