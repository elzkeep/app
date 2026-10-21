import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 주소검색(다음 우편번호 서비스). remedi_kopo 대체 —
// 그 패키지는 webview_flutter 2.x 에 묶여 최신 Android Gradle 빌드가 안 되고, 남의 GitHub Pages 페이지를 띄웠다.
// 여기서는 다음 우편번호 스크립트를 직접 불러와 선택 결과를 JavaScriptChannel 로 받는다.
class KopoModel {
  String? zonecode;
  String? address;
  String? roadAddress;
  String? jibunAddress;
  String? buildingName;
  String? sido;
  String? sigungu;

  KopoModel(
      {this.zonecode,
      this.address,
      this.roadAddress,
      this.jibunAddress,
      this.buildingName,
      this.sido,
      this.sigungu});

  factory KopoModel.fromJson(Map<String, dynamic> json) => KopoModel(
        zonecode: json['zonecode'],
        address: json['address'],
        roadAddress: json['roadAddress'],
        jibunAddress: json['jibunAddress'],
        buildingName: json['buildingName'],
        sido: json['sido'],
        sigungu: json['sigungu'],
      );
}

const _postcodeHtml = '''
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>html,body{margin:0;padding:0;height:100%;}#wrap{width:100%;height:100%;}</style>
</head>
<body>
<div id="wrap"></div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
new daum.Postcode({
  width: '100%',
  height: '100%',
  oncomplete: function (data) { onComplete.postMessage(JSON.stringify(data)); }
}).embed(document.getElementById('wrap'));
</script>
</body>
</html>
''';

// Get.to(() => KopoView()) 로 띄우면 선택한 주소(KopoModel)를 돌려준다. 뒤로 가면 null
class KopoView extends StatefulWidget {
  const KopoView({super.key, this.title = '주소검색'});

  final String title;

  @override
  State<KopoView> createState() => _KopoViewState();
}

class _KopoViewState extends State<KopoView> {
  late final WebViewController _controller;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('onComplete', onMessageReceived: (message) {
        if (_done) {
          return;
        }
        _done = true;
        final result = KopoModel.fromJson(jsonDecode(message.message));
        Navigator.pop(context, result);
      })
      ..loadHtmlString(_postcodeHtml,
          baseUrl: 'https://postcode.map.daum.net');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
