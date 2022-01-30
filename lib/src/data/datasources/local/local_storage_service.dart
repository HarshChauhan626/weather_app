import 'package:hive/hive.dart';

class LocalStorageService {
  LocalStorageService() {
    initData();
  }

  String boxName = "weatherCities";

  Box? box;

  void initData() async {
    box = await Hive.openBox(boxName);
  }

  void saveCity(String city) async {
    box?.add(city);
  }
}
