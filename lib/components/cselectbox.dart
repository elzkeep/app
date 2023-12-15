import 'package:common_control/common_control.dart';

class CItem {
  CItem({required this.id, required this.value});

  final int id;
  final dynamic value;
}

class CSelectbox extends CWidget {
  CSelectbox(
      {super.key,
      this.title = '',
      super.backgroundColor,
      required this.items,
      required this.selected,
      required this.onSelected});

  final String title;
  final List<CItem> items;
  final int selected;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    final context = Get.context!;

    final textStyle = Style(
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xff212121)),
      margin: const EdgeInsets.only(top: 16, bottom: 8),
    );

    final columnStyle = Style(
        mainAxisAlignment: MainAxisAlignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        gap: 20);

    TextStyle style = const TextStyle();

    if (selected == 0) {
      style = const TextStyle(color: Colors.black26);
    }

    List<Widget> types = [];

    for (var i = 0; i < items.length; i++) {
      final pos = i;

      Color color = Colors.black;

      if (items[pos].id == 0) {
        color = Colors.black26;
      }
      final widget = CRow(
          onTap: () {
            onSelected(items[pos].id);
            Navigator.pop(context);
          },
          children: [
            CText(items[i].value,
                backgroundColor: Colors.white,
                textStyle: TextStyle(color: color)),
          ]);

      types.add(widget);
    }

    final widget = CRow(children: [
      Expanded(
        child: CContainer(
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: items.length * 40 + 80,
                    color: Colors.white,
                    child: Center(
                      child: CColumn(style: columnStyle, children: types),
                    ),
                  );
                },
              );
            },
            decoration: BoxDecoration(
              color: backgroundColor,
                border: Border.all(
                  color: const Color(0xffE0E0E0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: CRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(items[selected].value, textStyle: style),
                CSvg('assets/imgs/arrow-down.svg'),
              ])
          ),
      ),
    ]);

    if (title == '') {
      return widget;
    }

    return CColumn(children: [CText(title, style: textStyle), widget]);
  }
}
