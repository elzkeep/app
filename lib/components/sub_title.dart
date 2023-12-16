import 'package:common_control/common_control.dart';
import 'package:zkeep/config/config.dart';

class SubTitle extends CWidget {
  SubTitle(this.title, {super.key, this.more = '', this.onMore});

  final String title;
  final String more;
  final Function()? onMore;

  @override
  Widget build(BuildContext context) {
    return CBothSide(children: [
        CText(title, style: Config.boxtitleStyle),
        more != '' ? CText(
          more,
          style: Config.moreStyle,
          onTap: onMore
        ) : const SizedBox.shrink(),
      ]);
  }
}
