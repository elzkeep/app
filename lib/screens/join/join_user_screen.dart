import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:zkeep/components/cformtext.dart';
import 'package:zkeep/components/cformtitle.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class JoinUserScreen extends CWidget {
  JoinUserScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      autoLostFocus: true,
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Get.back();
              c.company = Company();
              c.address = '';
            }),
      ),
      body: Obx(
        () => CFixedBottom(
            bottom: CButton(
                padding: const EdgeInsets.all(20),
                text: '회원 가입',
                disabled: c.email.isEmpty ||
                    c.passwd.isEmpty ||
                    c.passwdtwo.isEmpty ||
                    c.name.isEmpty ||
                    c.tel.isEmpty ||
                    (c.passwd != c.passwdtwo) ||
                    c.address.isEmpty ||
                    c.addressetc.isEmpty,
                onPressed: () async {
                  // var res = await c.join();
                  // if (res != true) {
                  //   return;
                  // }
                  Get.toNamed('/join/user/detail');
                },
                size: CButtonSize.large,
                margin: const EdgeInsets.only(top: 24, bottom: 0)),
            children: [
              CForm(padding: const EdgeInsets.all(20), children: [
                CFormfield(
                  title: '이메일',
                  onChanged: (value) => c.email = value,
                  errText: c.emailError,
                ),
                CFormfield(
                  title: '비밀번호',
                  onChanged: (value) => c.passwd = value,
                  errText: c.passwdError,
                ),
                CFormfield(
                  title: '비밀번호 확인',
                  onChanged: (value) => c.passwdtwo = value,
                  errText: c.passwdtwoError,
                ),
                CFormfield(
                  title: '이름',
                  onChanged: (value) => c.name = value,
                  errText: c.nameError,
                ),
                CFormfield(
                  title: '휴대폰번호',
                  onChanged: (value) => c.tel = value,
                ),
                CFormtitle(title: '주소'),
                CFormtext(c.address, onTap: () => searchAddress()),
                CFormfield(
                  onChanged: (value) => c.addressetc = value,
                ),
                CFormtitle(title: '회사선택'),
                CFormtext(c.company.name, onTap: () => clickCompany()),
              ]),
            ]),
      ),
    );
  }

  void searchAddress() async {
    KopoModel? model = await Get.to(() => RemediKopo());

    c.zip = model?.zonecode ?? '';
    c.address = model?.address ?? '';
  }

  clickCompany() {
    Get.dialog(
      barrierDismissible: true,
      AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: Get.width - 40,
            child: Obx(
              () => CColumn(
                gap: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
                children: [
                  const SizedBox(height: 0),
                  CRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        CText('회사 검색',
                            textStyle: const TextStyle(fontSize: 18)),
                        CContainer(
                            onTap: () => Get.back(),
                            child: const Icon(Icons.close, color: Colors.black))
                      ]),
                  const SizedBox(height: 5),
                  CTextField(
                      svg: 'assets/imgs/search.svg',
                      maxLines: 1,
                      onChanged: (value) {
                        c.search = value;
                      }),
                  companylist()
                ],
              ),
            ),
          )),
    );
  }

  companylist() {
    List<Widget> items = [];

    for (var i = 0; i < c.items.length; i++) {
      Company item = c.items[i];
      final name = item.name;

      if (c.search != '') {
        if (!name.contains(c.search)) {
          if (!containsInitialConsonant(name, c.search)) {
            continue;
          }
        }
      }

      items.add(CText(
        name,
        margin: const EdgeInsets.only(bottom: 10),
        onTap: () => clickSelectCustomer(item),
      ));
    }

    return CContainer(
        height: Get.height / 2,
        child: SingleChildScrollView(
            child: CRow(children: [
          Expanded(
              child: CColumn(
            children: items,
          ))
        ])));
  }

  clickSelectCustomer(Company item) {
    c.company = item;
    Get.back();
  }

  bool containsInitialConsonant(String string, String query) {
    /*
      Hangul UTF16 structure :
      ① Hangul characters start from 44032(== '가').
      ② A group of same initial consonant has 588 characters.
      ③ Initial consonants are 19ea,
        such as 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'
      ④ Hangul initial consonant characters start from 12593 to 12622
        'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅄ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ',
    */
    const codeOfFirstHangulLetter = 44032;
    const numberOfSameInitialConsonant = 588;
    final initialConsonants = [
      'ㄱ',
      'ㄲ',
      'ㄴ',
      'ㄷ',
      'ㄸ',
      'ㄹ',
      'ㅁ',
      'ㅂ',
      'ㅃ',
      'ㅅ',
      'ㅆ',
      'ㅇ',
      'ㅈ',
      'ㅉ',
      'ㅊ',
      'ㅋ',
      'ㅌ',
      'ㅍ',
      'ㅎ'
    ];

    if (string.length < query.length) {
      return false;
    }

    if (query.isEmpty) return true;

    for (int i = 0; i < string.length - query.length + 1; i++) {
      bool contains = true;
      for (int j = 0; j < query.length; j++) {
        if (initialConsonants.contains(query.substring(j, j + 1))) {
          if ((string.substring(i + j, i + j + 1).codeUnitAt(0) -
                      codeOfFirstHangulLetter) ~/
                  numberOfSameInitialConsonant !=
              initialConsonants.indexOf(query.substring(j, j + 1))) {
            contains = false;
            break;
          }
        } else {
          if (query.substring(j, j + 1) != string.substring(i + j, i + j + 1)) {
            contains = false;
            break;
          }
        }
      }
      if (contains) return true;
    }
    return false;
  }
}
