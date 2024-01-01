import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';

class FacilityInsertScreen extends CWidget {
  FacilityInsertScreen({super.key});

  final c = Get.find<FacilityInsertController>();

  final titleStyle = const TextStyle(color: Config.titleColor);
  final labelStyle = const TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(
        bottom: bottom(), children: [SingleChildScrollView(child: form())]);
  }

  bottom() {
    return CRow(padding: const EdgeInsets.only(bottom: 10), gap: 10, children: [
      CButton(
        text: '취소',
        flex: 1,
        size: CButtonSize.normal,
        type: CButtonStyle.outlined,
        onPressed: () => clickCancel(),
      ),
      CButton(
        text: '저장',
        flex: 1,
        size: CButtonSize.normal,
        onPressed: () => clickSave(),
      ),
    ]);
  }

  clickCancel() {
    Get.back();
  }

  clickSave() async {
    Get.back();
  }

  title(title) {
    return CText(
      title,
      textStyle: titleStyle,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  form() {
    return CColumn(children: [
      title('수배전설비'),
      Obx(() => arrangement()),
    ]);
  }

  round(widgets) {
    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            gap: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets));
  }

  entry(title, widget) {
    return CRow(children: [
      CText(
        title,
        width: 65,
        textStyle: labelStyle,
      ),
      Expanded(child: widget)
    ]);
  }

  entry2(title, widget, title2, widget2) {
    return CRow(children: [
      CText(
        title,
        width: 65,
        textStyle: labelStyle,
      ),
      Expanded(child: widget),
      const SizedBox(width: 10),
      CText(
        title2,
        width: 65,
        textStyle: labelStyle,
      ),
      Expanded(child: widget2)
    ]);
  }

  arrangement() {
    final types = CItem.list(['', '저압', '특고압']);
    final positions =
        CItem.list(['', '지하', '단독/옥내', '옥상', '옥외', '복도/계단', '현관', '직접입력']);

    return round(<Widget>[
      entry(
          '수전용량',
          CTextField(
            filledColor: Colors.white,
            suffixText: 'kW',
            textStyle: const TextStyle(fontSize: 14),
          )),
      entry(
          '수전형태',
          CSelectbox(
            backgroundColor: Colors.white,
            items: types,
            selected: c.type,
            onSelected: (pos) => c.type = pos,
          )),
      entry(
          '수전위치',
          CSelectbox(
            backgroundColor: Colors.white,
            items: positions,
            selected: c.position,
            onSelected: (pos) {
              c.position = pos;
            },
          )),
      c.position == positions.length - 1
          ? entry(
              '',
              CTextField(
                filledColor: Colors.white,
                textStyle: const TextStyle(fontSize: 14),
              ))
          : const SizedBox.shrink(),
    ]);
  }
}
