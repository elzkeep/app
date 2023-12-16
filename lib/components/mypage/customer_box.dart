import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/config/config.dart';

class CustomerBox extends CWidget {
  CustomerBox({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 12, color: Colors.black54);
    const countStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return CRound(
          backgroundColor: Config.backgroundColor,
          child: CRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: CRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          '관리고객수',
                          textStyle: textStyle,
                        ),
                        CText(
                          '28',
                          margin: const EdgeInsets.only(top: 10),
                          textStyle: countStyle,
                        ),
                      ]),
                ),
                CContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 1,
                    height: 40,
                    backgroundColor: Colors.black26),
                Flexible(
                    child: CRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      CText(
                        '관리점수',
                        textStyle: textStyle,
                      ),
                      CText(
                        '52',
                        margin: const EdgeInsets.only(top: 10),
                        textStyle: countStyle,
                      ),
                    ]))
              ]));

  }
}
