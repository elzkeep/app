import 'package:common_control/common_control.dart';

class CFormtext extends CWidget {
  CFormtext(this.text,
      {super.key,
      super.width,
      super.height,
      super.margin,
      super.padding,
      this.textStyle,
      super.border,
      super.flex,
      super.style,
      super.onTap,
      super.icon,
      super.rearIcon,
      super.backgroundColor,
      super.expanded,
      super.decoration,
      super.visible,
      super.borderRadius,
      this.overflow,
      this.maxLines,
      this.softWrap,
      this.errText = '',
      super.iconMargin,
      super.rearIconMargin,
      super.alignment,
      super.tag,
      this.textAlign});

  final String text;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextAlign? textAlign;
  final String errText;

  @override
  Widget init(BuildContext context) {
    final errorText = Style(
        margin: const EdgeInsets.only(top: 5),
        textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xffff6262)));

    if (errText != '') {
      final widget = CColumn(children: [
        CRow(children: [
          Expanded(
            child: CContainer(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE0E0E0),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CText(text, textStyle: const TextStyle(fontSize: 14)),
            ),
          ),
        ]),
        CText(errText, style: errorText),
      ]);

      return widget;
    }

    final widget = CRow(children: [
      Expanded(
        child: CContainer(
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE0E0E0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CText(text, textStyle: const TextStyle(fontSize: 14)),
        ),
      ),
    ]);

    return widget;
  }
}
