import 'package:common_control/common_control.dart';

class CRound extends CWidget {
  CRound({super.key, this.child});

  late final Widget? child;

  @override
  Widget init(BuildContext context) {
    child ??= SizedBox.shrink();

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE0E0E0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: child);
  }
}
