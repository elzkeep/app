import 'dart:convert';

import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/facility.dart';
import 'package:zkeep/models/facilityitem.dart';

class FacilityInsertController extends GetxController {
  FacilityInsertController(this.id, this.building);

  final c = Get.find<ViewController>();

  final int id;
  final int building;

  final _buildingName = ''.obs;
  String get buildingName => _buildingName.value;
  set buildingName(String value) => _buildingName.value = value;

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

  final _aswitch = true.obs;
  get aswitch => _aswitch.value;
  set aswitch(value) => _aswitch.value = value;

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
  final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900', '직접입력']).obs;
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
  final upskeeps = CItem.list(['', '보관안함', '보관(6개월)', '보관(1년)', '직접입력']).obs;
  final upstypes = CItem.list(['', '온라인', '오프라인']).obs;
  final upstimes =
      CItem.list(['', '30분', '1시간', '2시간', '3시간', '4시간', '직접입력']).obs;
  final gass = CItem.list(['', '도시가스', 'LPG', '바이오가스', '직접입력']).obs;
  final fueltypes = CItem.list(['', '옥상형', '옥외형']).obs;
  final fuelpositions = CItem.list(['', '독립형', '계통연계형']).obs;

  List<CItem> years = [CItem(id: 0, value: '')].obs;
  List<CItem> months = [CItem(id: 0, value: '')].obs;
  List<CItem> connecttranss = [CItem(id: 0, value: '')].obs;

  @override
  onInit() async {
    super.onInit();
    getYearMonth();
    getBuilding();
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

  getChargerTotal() {
    int total = 0;
    for (int i = 0; i < chargeritems.length; i++) {
      int value1 = int.tryParse(chargeritems[i].value1) ?? 0;
      int value2 = int.tryParse(chargeritems[i].value2) ?? 0;
      total += value1 * value2;
    }
    return total;
  }

  getYearMonth() {
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1969, value: '$i'));
    }

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }
  }

  getBuilding() async {
    final res = await BuildingManager.get(building);
    buildingName = res.name;
  }

  getItem() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=10');
    if (res.isEmpty) {
      item = Facility();
    } else {
      item = res[0];
    }

    if (item.value1 == 'true') {
      aswitch = true;
      installation = true;
    } else {
      aswitch = false;
      installation = false;
    }

    addExtra(item);
  }

  getItems() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=11');

    if (res.isEmpty) {
      items.add(Facility());
    } else {
      items = res;
    }

    for (int j = 0; j < items.length; j++) {
      addExtra(items[j]);
    }
  }

  getTranss() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=12');

    if (res.isEmpty) {
      transs.add(Facility());
      transs[0].name = "TR1";
    } else {
      transs = res;
    }

    for (int j = 0; j < transs.length; j++) {
      addExtra(transs[j]);
      connecttranss.add(CItem(id: j + 1, value: transs[j].name));
    }
  }

  getHighs() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=13');

    if (res.isEmpty) {
      Facility newFacility = Facility();
      newFacility.contents = [FacilityItem()];
      highs.add(newFacility);
      // Facility().contents.add(FacilityItem());
      // highs.add(Facility());
      // highs.add(Facility().contents.add(FacilityItem()));
    } else {
      highs = res;
    }

    for (int j = 0; j < highs.length; j++) {
      addExtra(highs[j]);
      for (int k = 0; k < highs[j].contents.length; k++) {
        addHighsExtra(highs[j].contents[k]);
      }
    }
  }

  getGenerator() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=20');

    if (res.isEmpty) {
      generator.add(Facility());
      generator[0].name = "$buildingName 발전설비";
    } else {
      generator = res;
      other[0] = true;
    }

    for (int j = 0; j < generator.length; j++) {
      addExtra(generator[j]);
    }
  }

  getSun() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=30');

    if (res.isNotEmpty) {
      sunlight = res[0];
      other[1] = true;
    } else {
      sunlight.name = "$buildingName 태양광발전";
    }

    addExtra(sunlight);
  }

  getCharger() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=40');

    if (res.isNotEmpty) {
      charger = res[0];
      other[2] = true;
    } else {
      charger.name = "$buildingName EV충전기";
    }

    addExtra(charger);
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

    for (int j = 0; j < chargeritems.length; j++) {
      addExtra(chargeritems[j]);
    }
  }

  getEss() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=50');

    if (res.isNotEmpty) {
      ess = res[0];
      other[3] = true;
    } else {
      ess.name = "$buildingName 전기저장장치";
    }

    addExtra(ess);
  }

  getUps() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=60');

    ups = res;

    if (ups.length == 0) {
      ups.add(Facility());
      ups[0].name = "$buildingName UPS";
    } else {
      other[4] = true;
    }

    for (int j = 0; j < ups.length; j++) {
      addExtra(ups[j]);
    }
  }

  getFuel() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=70');

    fuel = res;

    if (fuel.length == 0) {
      fuel.add(Facility());
      fuel[0].name = "$buildingName 연료전지 발전설비";
    } else {
      other[5] = true;
    }

    for (int j = 0; j < fuel.length; j++) {
      addExtra(fuel[j]);
    }
  }

  getWind() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=80');

    wind = res;

    if (wind.length == 0) {
      wind.add(Facility());
      wind[0].name = "$buildingName 풍력발전소";
    } else {
      other[6] = true;
    }

    for (int j = 0; j < wind.length; j++) {
      addExtra(wind[j]);
    }
  }

  getWater() async {
    final res =
        await FacilityManager.find(params: 'building=$building&category=90');

    if (res.isNotEmpty) {
      water = res[0];
      other[7] = true;
    } else {
      water.name = "$buildingName 수력발전설비";
    }

    addExtra(water);
  }

  remove(data, index) {
    for (int i = 0; i < highs.length; i++) {
      for (int j = 0; j < highs[i].contents.length; j++) {
        if (highs[i].contents[j].value7 == (index + 1).toString()) {
          highs[i].contents[j].value7 = 0.toString();
          highsRedraw();
        }
      }
    }
    data.removeAt(index);
    connecttranss = [CItem(id: 0, value: '')];
    for (int j = 0; j < transs.length; j++) {
      connecttranss.add(CItem(id: j + 1, value: transs[j].name));
    }
    itemsRedraw();
  }

  addItem(data, String item) {
    data.add(Facility());
    var j = data.length - 1;
    if (item == 'transs') {
      data[j].name = 'TR${data.length}';
      connecttranss = [CItem(id: 0, value: '')];
      for (int j = 0; j < transs.length; j++) {
        connecttranss.add(CItem(id: j + 1, value: transs[j].name));
      }
    }
    if (item == 'generator') {
      data[j].name = "$buildingName 발전설비";
    }
    if (item == 'ups') {
      data[j].name = "$buildingName UPS";
    }
    if (item == 'fuel') {
      data[j].name = "$buildingName 연료전지 발전설비";
    }
    if (item == 'wind') {
      data[j].name = "$buildingName 풍력발전소";
    }
    if (item == 'highs') {
      data[j].contents = [FacilityItem()];
      addHighsExtra(data[j].contents[0]);
    }
    addExtra(data[j]);
  }

  addExtra(data) {
    data.extra = <String, TextEditingController>{
      'name': TextEditingController(),
      'value1': TextEditingController(),
      'value2': TextEditingController(),
      'value3': TextEditingController(),
      'value4': TextEditingController(),
      'value5': TextEditingController(),
      'value6': TextEditingController(),
      'value7': TextEditingController(),
      'value8': TextEditingController(),
      'value9': TextEditingController(),
      'value10': TextEditingController(),
      'value11': TextEditingController(),
      'value12': TextEditingController(),
      'value13': TextEditingController(),
      'value14': TextEditingController(),
      'value15': TextEditingController(),
      'value16': TextEditingController(),
      'value17': TextEditingController(),
      'value18': TextEditingController(),
      'value19': TextEditingController(),
      'value20': TextEditingController(),
      'value21': TextEditingController(),
      'value22': TextEditingController(),
      'value23': TextEditingController(),
      'value24': TextEditingController(),
      'value25': TextEditingController(),
    };
    data.extra['name'].text = data.name;
    data.extra['value1'].text = data.value1;
    data.extra['value2'].text = data.value2;
    data.extra['value3'].text = data.value3;
    data.extra['value4'].text = data.value4;
    data.extra['value5'].text = data.value5;
    data.extra['value6'].text = data.value6;
    data.extra['value7'].text = data.value7;
    data.extra['value8'].text = data.value8;
    data.extra['value9'].text = data.value9;
    data.extra['value10'].text = data.value10;
    data.extra['value11'].text = data.value11;
    data.extra['value12'].text = data.value12;
    data.extra['value13'].text = data.value13;
    data.extra['value14'].text = data.value14;
    data.extra['value15'].text = data.value15;
    data.extra['value16'].text = data.value16;
    data.extra['value17'].text = data.value17;
    data.extra['value18'].text = data.value18;
    data.extra['value19'].text = data.value19;
    data.extra['value20'].text = data.value20;
    data.extra['value21'].text = data.value21;
    data.extra['value22'].text = data.value22;
    data.extra['value23'].text = data.value23;
    data.extra['value24'].text = data.value24;
    data.extra['value25'].text = data.value25;
  }

  addHighsExtra(data) {
    data.extra = <String, TextEditingController>{
      'value1': TextEditingController(),
      'value2': TextEditingController(),
      'value3': TextEditingController(),
      'value4': TextEditingController(),
      'value5': TextEditingController(),
      'value6': TextEditingController(),
      'value7': TextEditingController(),
      'value8': TextEditingController(),
      'value9': TextEditingController(),
      'value10': TextEditingController(),
    };
    data.extra['value1'].text = data.value1;
    data.extra['value2'].text = data.value2;
    data.extra['value3'].text = data.value3;
    data.extra['value4'].text = data.value4;
    data.extra['value5'].text = data.value5;
    data.extra['value6'].text = data.value6;
    data.extra['value7'].text = data.value7;
    data.extra['value8'].text = data.value8;
    data.extra['value9'].text = data.value9;
    data.extra['value10'].text = data.value10;
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

  save() async {
    int itemId = item.id;
    if (aswitch == false) {
      item = Facility();
      item.id = itemId;
    }

    item.building = building;
    item.category = 10;
    item.value1 = aswitch.toString();

    if (item.id > 0) {
      await FacilityManager.update(item);
    } else {
      await FacilityManager.insert(item);
    }

    await FacilityManager.deleteByBuildingCategory(building, 11);

    if (aswitch == true) {
      for (int i = 0; i < items.length; i++) {
        items[i].building = building;
        items[i].category = 11;
        await FacilityManager.insert(items[i]);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 12);
    await FacilityManager.deleteByBuildingCategory(building, 13);

    if (aswitch == true) {
      if (item.value3 == '2') {
        for (int i = 0; i < transs.length; i++) {
          transs[i].building = building;
          transs[i].category = 12;
          await FacilityManager.insert(transs[i]);
        }

        for (int i = 0; i < highs.length; i++) {
          highs[i].building = building;
          highs[i].category = 13;
          highs[i].content = jsonEncode(highs[i].contents);
          await FacilityManager.insert(highs[i]);
        }
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 20);

    if (other[0] == true) {
      for (int i = 0; i < generator.length; i++) {
        generator[i].building = building;
        generator[i].category = 20;
        await FacilityManager.insert(generator[i]);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 30);

    sunlight.building = building;
    sunlight.category = 30;
    if (other[1] == true) {
      if (sunlight.id > 0) {
        await FacilityManager.update(sunlight);
      } else {
        await FacilityManager.insert(sunlight);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 40);
    charger.building = building;
    charger.category = 40;

    await FacilityManager.deleteByBuildingCategory(building, 41);
    if (other[2] == true) {
      if (charger.id > 0) {
        await FacilityManager.update(charger);
      } else {
        await FacilityManager.insert(charger);
      }

      for (int i = 0; i < chargeritems.length; i++) {
        chargeritems[i].building = building;
        chargeritems[i].category = 41;
        await FacilityManager.insert(chargeritems[i]);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 50);
    ess.building = building;
    ess.category = 50;
    if (other[3] == true) {
      if (ess.id > 0) {
        await FacilityManager.update(ess);
      } else {
        await FacilityManager.insert(ess);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 60);
    if (other[4] == true) {
      for (int i = 0; i < ups.length; i++) {
        ups[i].building = building;
        ups[i].category = 60;
        await FacilityManager.insert(ups[i]);
      }
    }

    await FacilityManager.deleteByBuildingCategory(building, 70);
    if (other[5] == true) {
      for (int i = 0; i < fuel.length; i++) {
        fuel[i].building = building;
        fuel[i].category = 70;
        await FacilityManager.insert(fuel[i]);
      }
    }
    await FacilityManager.deleteByBuildingCategory(building, 80);
    if (other[6] == true) {
      for (int i = 0; i < wind.length; i++) {
        wind[i].building = building;
        wind[i].category = 80;
        await FacilityManager.insert(wind[i]);
      }
    }
    await FacilityManager.deleteByBuildingCategory(building, 90);
    water.building = building;
    water.category = 90;
    if (other[7] == true) {
      if (water.id > 0) {
        await FacilityManager.update(water);
      } else {
        await FacilityManager.insert(water);
      }
    }

    await BuildingManager.score(Building(id: building));

    c.other = other;
    c.item = item;
    c.items = items;
    c.transs = transs;
    c.highs = highs;
    c.generator = generator;
    c.sunlight = sunlight;
    c.charger = charger;
    c.chargeritems = chargeritems;
    c.ess = ess;
    c.ups = ups;
    c.fuel = fuel;
    c.wind = wind;
    c.water = water;
    print("complete");
  }
}
