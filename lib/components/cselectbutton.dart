import 'package:common_control/common_control.dart';

class CSelectButton extends CWidget {
  CSelectButton(
      {super.key, required this.items, required this.index, this.onSelected});

  final List<String> items;
  final int index;
  final Function(int)? onSelected;

  @override
  build(BuildContext context) {
    return search();
  }

  search() {
    List<Widget> widgets = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      final widget = btn(item, i + 1);
      widgets.add(widget);
    }

    return Wrap(spacing: 5, runSpacing: 5, children: widgets);
  }

  click(index) {
    if (onSelected == null) {
      return;
    }

    onSelected!(index);
  }

  btn(title, pos) {
    if (pos == index) {
      return OutlinedButton(
          onPressed: () => click(pos),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54,
              side: const BorderSide(width: 0, color: Colors.transparent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ));
    } else {
      return OutlinedButton(
          onPressed: () => click(pos),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(width: 1.0, color: Colors.black54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ));
    }
  }
}
