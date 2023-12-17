import 'package:common_control/common_control.dart';

class CFormtitle extends CWidget {
  CFormtitle({super.key, required this.title, this.errText = ''});

  final String title;
  final String errText;

  @override
  Widget build(BuildContext context) {
    const errorText = TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffff6262));

    final textStyle = Style(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff212121)),
      margin: const EdgeInsets.only(
        top: 16,
      ),
    );

    if (errText != '') {
      return CColumn(children: [
        CText(title, style: textStyle),
        CText(errText, textStyle: errorText)
      ]);
    }
    return CText(title, style: textStyle);
  }
}
