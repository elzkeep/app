import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';

class BoxTitle extends CWidget {
  BoxTitle({super.key, this.text = '', required this.controller, this.expand = false, required this.onExpand});

  final String text;
  final TextEditingController controller;
  final bool expand;
  final Function(bool) onExpand;

  @override
  Widget build(BuildContext context) {
    return CRow(
                gap: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: CTextField(text: text, controller: controller, filledColor: Colors.white),),
                  CContainer(onTap: () => click(), child: expand == true ? const Icon(CupertinoIcons.plus, size: 20) : const Icon(CupertinoIcons.minus, size: 20)),
              ]);
  }

  click() {
    onExpand(expand);
  }
}
