import 'package:animalcrossingdb/object_class.dart';

List<Fossil> mapFossilsList(List<Map<String, dynamic>> qFossils) {
  List<Fossil> fossils = new List<Fossil>();
  qFossils.forEach((val) {
    Fossil fossil = new Fossil();
    fossil.number = val["number"];
    fossil.name = val["name"];
    fossil.price = val["price"];
    fossil.donated = val["donated"];
    fossil.quantity = val["quantity"];
    fossils.add(fossil);
  });
  return fossils;
}

List<Fish> mapFishList(List<Map<String, dynamic>> qFishes) {
  List<Fish> fishes = new List<Fish>();
  qFishes.forEach((val) {
    Fish fish = new Fish();
    fish.number = val["number"];
    fish.name = val["name"];
    fish.location = val["location"];
    fish.shadowSize = val["shadowSize"];
    fish.value = val["value"];
    fish.time = val["time"];
    fish.month = val["month"];
    fish.donated = val["donated"];
    fish.quantity = val["quantity"];
    fishes.add(fish);
  });
  return fishes;
}

List<Insect> mapInsectList(List<Map<String, dynamic>> qInsects) {
  List<Insect> insects = new List<Insect>();
  qInsects.forEach((val) {
    Insect insect = new Insect();
    insect.number = val["number"];
    insect.name = val["name"];
    insect.location = val["location"];
    insect.value = val["value"];
    insect.time = val["time"];
    insect.month = val["month"];
    insect.donated = val["donated"];
    insect.quantity = val["quantity"];
    insects.add(insect);
  });
  return insects;
}

List<Villager> mapVillagersList(List<Map<String, dynamic>> qVillagers) {
  List<Villager> villagers = new List<Villager>();
  qVillagers.forEach((val) {
    Villager villager = new Villager();
    villager.name = val["name"];
    villager.personality = val["personality"];
    villager.species = val["species"];
    villager.birthday = val["birthday"];
    villager.catchphrase = val["catchphrase"];
    villager.imageUrl = val["imageUrl"];
    villager.resident = val["resident"];
    villagers.add(villager);
  });
  return villagers;
}
