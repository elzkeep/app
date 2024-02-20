import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/facility.dart';

class FacilityInsertController extends GetxController {
  FacilityInsertController(this.id, this.building);

  final int id;
  final int building;

  final _item = Facility().obs;
  Facility get item => _item.value;
  set item(Facility value) => _item.value = value;

  final _installation = false.obs;
  bool get installation => _installation.value;
  set installation(bool value) => _installation.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _transs = [].obs;
  get transs => _transs;
  set transs(value) => _transs.value = value;

  final _highs = [].obs;
  get highs => _highs;
  set highs(value) => _highs.value = value;

  final _generator = [].obs;
  get generator => _generator;
  set generator(value) => _generator.value = value;

  final _sunlight = Facility().obs;
  Facility get sunlight => _sunlight.value;
  set sunlight(Facility value) => _sunlight.value = value;

  final _charger = Facility().obs;
  Facility get charger => _charger.value;
  set charger(Facility value) => _charger.value = value;

  final _chargeritems = [].obs;
  get chargeritems => _chargeritems;
  set chargeritems(value) => _chargeritems.value = value;

  final _chargertotal = 0.obs;
  get chargertotal => _chargertotal.value;
  set chargertotal(value) => _chargertotal.value = value;

  final _ess = Facility().obs;
  Facility get ess => _ess.value;
  set ess(Facility value) => _ess.value = value;

  final _ups = [].obs;
  get ups => _ups;
  set ups(value) => _ups.value = value;

  final _fuel = [].obs;
  get fuel => _fuel;
  set fuel(value) => _fuel.value = value;

  final _wind = [].obs;
  get wind => _wind;
  set wind(value) => _wind.value = value;

  final _water = Facility().obs;
  Facility get water => _water.value;
  set water(Facility value) => _water.value = value;

  final _other = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ].obs;
  get other => _other;
  set other(value) => _other.value = value;

  final _relay = 0.obs;
  int get relay => _relay.value;
  set relay(int value) => _relay.value = value;

  final _relayconnect = 0.obs;
  int get relayconnect => _relayconnect.value;
  set relayconnect(int value) => _relayconnect.value = value;

  final types = CItem.list(['', '저압', '특고압']).obs;
  final positions =
      CItem.list(['', '지하', '단독/옥내', '옥상', '옥외', '복도/계단', '현관', '직접입력']).obs;
  final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900']).obs;
  final voltage = CItem.list(['', '380/220V', '220V', '직접입력']).obs;
  final arrangementtypes = CItem.list(['', '일반형', '일체형']).obs;
  final faces = CItem.list([
    '',
    '1~5',
    '6~10',
    '11~20',
    '21~30',
    '31~40',
    '41~50',
    '51~60',
    '61~70',
    '71~80',
    '81~90',
    '91~100',
    '11~20',
    '101이상',
    '직접입력'
  ]).obs;
  final distributationtypes = CItem.list(['', '매입형', '노출형']).obs;
  final transstypes = CItem.list(['', '유입형', '몰드형']).obs;
  final breakers = CItem.list(['', 'VCB', 'GCV']).obs;
  final relays = CItem.list(['', 'OCR', 'OCGR', 'UVR', 'OVR', 'POR']).obs;
  final place = CItem.list(['', '옥상', '옥외', '임야', '직접입력']).obs;
  final coolings = CItem.list([
    '',
    '고정자(수냉각)',
    '고정자(수소냉각)',
    '고정자(공기냉각)',
    '고정자(권선냉각)',
    '회전자(간접냉각)',
    '회전자(직접냉각)'
  ]).obs;
  final activations = CItem.list(['', '전기식', '공기식']);
  final generatortype =
      CItem.list(['', 'ACB(기중차단기)', 'MCCB(배선용차단기)', 'ELB(누전차단기)']);
  final evplace = CItem.list(['', '옥상', '옥외', '직접입력']).obs;
  final evform = CItem.list(['', 'DC차데모', 'DC콤보', 'AC3상']).obs;
  final esstype =
      CItem.list(['', '리튬이온', '니켈카드뮴', '니켈염화', '나트륨 황', '금속공기', '니켈수소', '직접입력'])
          .obs;
  final upspositions =
      CItem.list(['', '옥내', '옥상(컨테이너)', '옥외(전용건물)', '직접입력']).obs;
  final upscctvs = CItem.list(['', '설치', '미설치']).obs;
  final upsusages =
      CItem.list(['', '통신부하', '전산부하', '비상부하', '소방/EL등', '직접입력']).obs;
  final upskeeps = CItem.list(['', '보관안함', '보관(6개월)', '보관(1년)', '직력입력']).obs;
  final upstypes = CItem.list(['', '온라인', '오프라인']).obs;
  final upstimes =
      CItem.list(['', '30분', '1시간', '2시간', '3시간', '4시간', '직력입력']).obs;
  final gass = CItem.list(['', '도시가스', 'LPG', '바이오가스', '직접입력']).obs;
  final fueltypes = CItem.list(['', '옥상형', '옥외형']).obs;
  final fuelpositions = CItem.list(['', '독립형', '계통연계형']).obs;

  List<CItem> years = [CItem(id: 0, value: '')].obs;
  List<CItem> months = [CItem(id: 0, value: '')].obs;

  @override
  onInit() async {
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1969, value: '$i'));
    }

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    Map<String, TextEditingController> itemextra = {};
    Map<String, TextEditingController> transsextra = {};
    Map<String, TextEditingController> highsextra = {};
    Map<String, TextEditingController> generatorextra = {
      'name': TextEditingController(),
    };
    Map<String, TextEditingController> sunlightextra = {};
    Map<String, TextEditingController> chargerextra = {};
    Map<String, TextEditingController> chargeritemsextra = {};
    Map<String, TextEditingController> essextra = {};
    Map<String, TextEditingController> upsextra = {
      'name': TextEditingController(),
    };
    Map<String, TextEditingController> fuelextra = {
      'name': TextEditingController(),
    };
    Map<String, TextEditingController> windextra = {
      'name': TextEditingController(),
    };
    Map<String, TextEditingController> waterextra = {
      'name': TextEditingController(),
    };

    for (int i = 1; i <= 20; i++) {
      itemextra['value$i'] = TextEditingController();
      transsextra['value$i'] = TextEditingController();
      highsextra['value$i'] = TextEditingController();
      generatorextra['value$i'] = TextEditingController();
      sunlightextra['value$i'] = TextEditingController();
      chargerextra['value$i'] = TextEditingController();
      chargeritemsextra['value$i'] = TextEditingController();
      essextra['value$i'] = TextEditingController();
      upsextra['value$i'] = TextEditingController();
      fuelextra['value$i'] = TextEditingController();
      windextra['value$i'] = TextEditingController();
      waterextra['value$i'] = TextEditingController();
    }

    super.onInit();

    items =
        await FacilityManager.find(params: 'building=$building&category=10');
    if (items.length == 0) {
      item = Facility();
    } else {
      item = items[0];
    }

    if (item.value1 == 'true') {
      installation = true;
    } else {
      installation = false;
    }

    item.extra = itemextra;
    item.extra['value2'].text = item.value2;
    item.extra['value10'].text = item.value10;

    items =
        await FacilityManager.find(params: 'building=$building&category=11');

    if (items.length == 0) {
      items.add(Facility());
    }

    transs =
        await FacilityManager.find(params: 'building=$building&category=12');

    if (transs.length == 0) {
      transs.add(Facility());
    }

    for (int j = 0; j < transs.length; j++) {
      transs[j].extra = transsextra;
      transs[j].extra['value1'].text = transs[j].value1;
      transs[j].extra['value2'].text = transs[j].value2;
      transs[j].extra['value3'].text = transs[j].value3;
      transs[j].extra['value4'].text = transs[j].value4;
      transs[j].extra['value5'].text = transs[j].value5;
      transs[j].extra['value6'].text = transs[j].value6;
      transs[j].extra['value7'].text = transs[j].value7;
      transs[j].extra['value8'].text = transs[j].value8;
      transs[j].extra['value9'].text = transs[j].value9;
    }

    highs =
        await FacilityManager.find(params: 'building=$building&category=13');
    if (highs.length == 0) {
      highs.add(Facility());
    }

    for (int j = 0; j < highs.length; j++) {
      highs[j].extra = highsextra;
      highs[j].extra['value1'].text = highs[j].value1;
      highs[j].extra['value2'].text = highs[j].value2;
      highs[j].extra['value3'].text = highs[j].value3;
      highs[j].extra['value4'].text = highs[j].value4;
      highs[j].extra['value5'].text = highs[j].value5;
      highs[j].extra['value6'].text = highs[j].value6;
      highs[j].extra['value7'].text = highs[j].value7;
      highs[j].extra['value8'].text = highs[j].value8;
      highs[j].extra['value9'].text = highs[j].value9;
    }

    generator =
        await FacilityManager.find(params: 'building=$building&category=20');
    if (generator.length == 0) {
      generator.add(Facility());
    }

    for (int j = 0; j < generator.length; j++) {
      generator[j].extra = generatorextra;
      generator[j].extra['name'].text = generator[j].name;
      generator[j].extra['value1'].text = generator[j].value1;
      generator[j].extra['value2'].text = generator[j].value2;
      generator[j].extra['value3'].text = generator[j].value3;
      generator[j].extra['value4'].text = generator[j].value4;
      generator[j].extra['value5'].text = generator[j].value5;
      generator[j].extra['value6'].text = generator[j].value6;
      generator[j].extra['value7'].text = generator[j].value7;
      generator[j].extra['value8'].text = generator[j].value8;
      generator[j].extra['value9'].text = generator[j].value9;
    }

    final res =
        await FacilityManager.find(params: 'building=$building&category=30');

    if (res.isNotEmpty) {
      sunlight = res[0];
      other[1] = true;
    }

    sunlight.extra = sunlightextra;
    sunlight.extra['value1'].text = sunlight.value1;
    sunlight.extra['value2'].text = sunlight.value2;
    sunlight.extra['value3'].text = sunlight.value3;
    sunlight.extra['value4'].text = sunlight.value4;
    sunlight.extra['value5'].text = sunlight.value5;
    sunlight.extra['value6'].text = sunlight.value6;
    sunlight.extra['value7'].text = sunlight.value7;
    sunlight.extra['value8'].text = sunlight.value8;
    sunlight.extra['value9'].text = sunlight.value9;

    final rescharger =
        await FacilityManager.find(params: 'building=$building&category=40');

    if (rescharger.isNotEmpty) {
      charger = rescharger[0];
      other[2] = true;
    }

    charger.extra = chargerextra;
    charger.extra['value1'].text = charger.value1;
    charger.extra['value2'].text = charger.value2;
    charger.extra['value3'].text = charger.value3;
    charger.extra['value4'].text = charger.value4;
    charger.extra['value5'].text = charger.value5;
    charger.extra['value6'].text = charger.value6;
    charger.extra['value7'].text = charger.value7;
    charger.extra['value8'].text = charger.value8;
    charger.extra['value9'].text = charger.value9;

    final reschargeritems =
        await FacilityManager.find(params: 'building=$building&category=41');

    chargeritems = reschargeritems;

    if (chargeritems.length == 0) {
      chargeritems.add(Facility());
    }

    for (int j = 0; j < chargeritems.length; j++) {
      chargeritems[j].extra = chargeritemsextra;
      chargeritems[j].extra['value1'].text = chargeritems[j].value1;
      chargeritems[j].extra['value2'].text = chargeritems[j].value2;
      chargeritems[j].extra['value3'].text = chargeritems[j].value3;
      chargeritems[j].extra['value4'].text = chargeritems[j].value4;
      chargeritems[j].extra['value5'].text = chargeritems[j].value5;
      chargeritems[j].extra['value6'].text = chargeritems[j].value6;
      chargeritems[j].extra['value7'].text = chargeritems[j].value7;
      chargeritems[j].extra['value8'].text = chargeritems[j].value8;
      chargeritems[j].extra['value9'].text = chargeritems[j].value9;
    }

    final resess =
        await FacilityManager.find(params: 'building=$building&category=50');

    if (resess.isNotEmpty) {
      ess = resess[0];
      other[3] = true;
    }

    ess.extra = essextra;
    ess.extra['value1'].text = ess.value1;
    ess.extra['value2'].text = ess.value2;
    ess.extra['value3'].text = ess.value3;
    ess.extra['value4'].text = ess.value4;
    ess.extra['value5'].text = ess.value5;
    ess.extra['value6'].text = ess.value6;
    ess.extra['value7'].text = ess.value7;
    ess.extra['value8'].text = ess.value8;
    ess.extra['value9'].text = ess.value9;

    final resups =
        await FacilityManager.find(params: 'building=$building&category=60');

    ups = resups;

    if (ups.length == 0) {
      ups.add(Facility());
    } else {
      other[4] = true;
    }

    for (int j = 0; j < ups.length; j++) {
      ups[j].extra = upsextra;
      ups[j].extra['name'].text = ups[j].name;
      ups[j].extra['value1'].text = ups[j].value1;
      ups[j].extra['value2'].text = ups[j].value2;
      ups[j].extra['value3'].text = ups[j].value3;
      ups[j].extra['value4'].text = ups[j].value4;
      ups[j].extra['value5'].text = ups[j].value5;
      ups[j].extra['value6'].text = ups[j].value6;
      ups[j].extra['value7'].text = ups[j].value7;
      ups[j].extra['value8'].text = ups[j].value8;
      ups[j].extra['value9'].text = ups[j].value9;
    }

    final resfuel =
        await FacilityManager.find(params: 'building=$building&category=70');

    fuel = resfuel;

    if (fuel.length == 0) {
      fuel.add(Facility());
    } else {
      other[5] = true;
    }

    for (int j = 0; j < fuel.length; j++) {
      fuel[j].extra = fuelextra;
      fuel[j].extra['name'].text = fuel[j].name;
      fuel[j].extra['value1'].text = fuel[j].value1;
      fuel[j].extra['value2'].text = fuel[j].value2;
      fuel[j].extra['value3'].text = fuel[j].value3;
      fuel[j].extra['value4'].text = fuel[j].value4;
      fuel[j].extra['value5'].text = fuel[j].value5;
      fuel[j].extra['value6'].text = fuel[j].value6;
      fuel[j].extra['value7'].text = fuel[j].value7;
      fuel[j].extra['value8'].text = fuel[j].value8;
      fuel[j].extra['value9'].text = fuel[j].value9;
    }

    final reswind =
        await FacilityManager.find(params: 'building=$building&category=80');

    wind = reswind;

    if (wind.length == 0) {
      wind.add(Facility());
    } else {
      other[6] = true;
    }

    for (int j = 0; j < wind.length; j++) {
      wind[j].extra = windextra;
      wind[j].extra['name'].text = wind[j].name;
      wind[j].extra['value1'].text = wind[j].value1;
      wind[j].extra['value2'].text = wind[j].value2;
      wind[j].extra['value3'].text = wind[j].value3;
      wind[j].extra['value4'].text = wind[j].value4;
      wind[j].extra['value5'].text = wind[j].value5;
      wind[j].extra['value6'].text = wind[j].value6;
      wind[j].extra['value7'].text = wind[j].value7;
      wind[j].extra['value8'].text = wind[j].value8;
      wind[j].extra['value9'].text = wind[j].value9;
    }

    final reswater =
        await FacilityManager.find(params: 'building=$building&category=90');

    if (reswater.isNotEmpty) {
      water = reswater[0];
      other[7] = true;
    }

    water.extra = waterextra;
    water.extra['name'].text = water.name;
    water.extra['value1'].text = water.value2;
    water.extra['value2'].text = water.value3;
  }

  remove(data, index) {
    data.value.removeAt(index);
    itemsRedraw();
  }

  itemRedraw() {
    _item.refresh();
  }

  itemsRedraw() {
    _items.refresh();
  }

  transsRedraw() {
    _transs.refresh();
  }

  highsRedraw() {
    _highs.refresh();
  }

  generatorRedraw() {
    _generator.refresh();
  }

  sunlightRedraw() {
    _sunlight.refresh();
  }

  chargerRedraw() {
    _charger.refresh();
  }

  chargeritemsRedraw() {
    _chargeritems.refresh();
  }

  essRedraw() {
    _ess.refresh();
  }

  upsRedraw() {
    _ups.refresh();
  }

  fuelRedraw() {
    _fuel.refresh();
  }

  windRedraw() {
    _wind.refresh();
  }

  waterRedraw() {
    _water.refresh();
  }

  bool toBoolean(String str) {
    return str == 'true';
  }
}
