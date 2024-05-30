import 'dart:async';
import 'dart:js' as js;
import 'package:common_control/common_control.dart';
import 'package:flutter/material.dart';

import 'package:remedi_kopo/remedi_kopo.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final Timer timer;

  @override
  void initState() {
    js.context.callMethod("aa");
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      js.JsObject obj = js.JsObject.fromBrowserObject(js.context['add']);
      if (obj['address'] != null) {
        KopoModel result =
            KopoModel(address: obj['address'], zonecode: obj['zonecode']);
        Navigator.pop(context, result);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주소 찾기"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              js.context.callMethod("bb");
              Navigator.pop(context, KopoModel());
            }),
      ),
      // body: Center(
      //   child: TextButton(
      //     child: const Text("선택"),
      //     onPressed: () {
      //       js.JsObject obj = js.JsObject.fromBrowserObject(js.context['add']);
      //       print(obj['address']);
      //       print(obj['zonecode']);
      //       KopoModel result =
      //           KopoModel(address: obj['address'], zonecode: obj['zonecode']);
      //       Navigator.pop(context, result);
      //     },
      //   ),
      // ),
    );
  }
}

// import 'dart:async';
// import 'dart:js' as js;
// import 'package:common_control/common_control.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:remedi_kopo/remedi_kopo.dart';
// import 'address_controller.dart';

// class MapView extends CWidget {
//   MapView({Key? key}) : super(key: key);

//   final AddressController c = Get.put<AddressController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("카카오 우편번호 서비스"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () {
//             js.context.callMethod("bb");
//             Navigator.pop(context, KopoModel());
//           },
//         ),
//       ),
//       body: Center(
//         child: Obx(() {
//           return Text('Selected Address: ${c.address}');
//         }),
//       ),
//     );
//   }
// }
