import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/facility.dart';

class FacilityViewController extends GetxController {
  FacilityViewController(this.id, this.building);

  final int id;
  final int building;

  final _item = Facility().obs;
  Facility get item => _item.value;
  set item(Facility value) => _item.value = value;

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
    super.onInit();
    // item = await FacilityManager.get(id);
    getYearMonth();
    getItem();
    getItems();
    getTranss();
    getHighs();
    getGenerator();
    getSun();
    getCharger();
    getChargerItem();
    getEss();
    getUps();
    getFuel();
    getWind();
    getWater();
  }

  getYearMonth() {
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1969, value: '$i'));
    }

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }
  }

  getItem() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=10');
    if (res.isEmpty) {
      item = Facility();
    } else {
      item = res[0];
    }
  }

  getItems() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=11');

    if (res.isEmpty) {
      items.add(Facility());
    } else {
      items = res;
    }
  }

  getTranss() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=12');

    if (res.isEmpty) {
      transs.add(Facility());
    } else {
      transs = res;
    }
  }

  getHighs() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=13');

    if (res.isEmpty) {
      highs.add(Facility());
    } else {
      highs = res;
    }
  }

  getGenerator() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=20');

    if (res.isEmpty) {
      generator.add(Facility());
    } else {
      generator = res;
      other[0] = true;
    }
  }

  getSun() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=30');

    if (res.isNotEmpty) {
      sunlight = res[0];
      other[1] = true;
    }
  }

  getCharger() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=40');

    if (res.isNotEmpty) {
      charger = res[0];
      other[2] = true;
    }
  }

  getChargerItem() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=41');

    chargeritems = res;

    if (res.isEmpty) {
      chargeritems.add(Facility());
    } else {
      chargeritems = res;
    }
  }

  getEss() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=50');

    if (res.isNotEmpty) {
      ess = res[0];
      other[3] = true;
    }
  }

  getUps() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=60');

    ups = res;

    if (ups.length == 0) {
      ups.add(Facility());
    } else {
      other[4] = true;
    }
  }

  getFuel() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=70');

    fuel = res;

    if (fuel.length == 0) {
      fuel.add(Facility());
    } else {
      other[5] = true;
    }
  }

  getWind() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=80');

    wind = res;

    if (wind.length == 0) {
      wind.add(Facility());
    } else {
      other[6] = true;
    }
  }

  getWater() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=90');

    if (res.isNotEmpty) {
      water = res[0];
      other[7] = true;
    }
  }
}
