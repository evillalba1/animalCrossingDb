import 'package:animalcrossingdb/object_class.dart';
import 'dart:convert';

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
    fish.imageUrl = val["imageUrl"];
    fish.january = val["january"];
    fish.february = val["february"];
    fish.march = val["march"];
    fish.april = val["april"];
    fish.may = val["may"];
    fish.june = val["june"];
    fish.july = val["july"];
    fish.august = val["august"];
    fish.september = val["september"];
    fish.october = val["october"];
    fish.november = val["november"];
    fish.december = val["december"];
    fish.januaryS = val["januaryS"];
    fish.februaryS = val["februaryS"];
    fish.marchS = val["marchS"];
    fish.aprilS = val["aprilS"];
    fish.mayS = val["mayS"];
    fish.juneS = val["juneS"];
    fish.julyS = val["julyS"];
    fish.augustS = val["augustS"];
    fish.septemberS = val["septemberS"];
    fish.octoberS = val["octoberS"];
    fish.novemberS = val["novemberS"];
    fish.decemberS = val["decemberS"];
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
    insect.imageUrl = val["imageUrl"];
    insect.january = val["january"];
    insect.february = val["february"];
    insect.march = val["march"];
    insect.april = val["april"];
    insect.may = val["may"];
    insect.june = val["june"];
    insect.july = val["july"];
    insect.august = val["august"];
    insect.september = val["september"];
    insect.october = val["october"];
    insect.november = val["november"];
    insect.december = val["december"];
    insect.januaryS = val["januaryS"];
    insect.februaryS = val["februaryS"];
    insect.marchS = val["marchS"];
    insect.aprilS = val["aprilS"];
    insect.mayS = val["mayS"];
    insect.juneS = val["juneS"];
    insect.julyS = val["julyS"];
    insect.augustS = val["augustS"];
    insect.septemberS = val["septemberS"];
    insect.octoberS = val["octoberS"];
    insect.novemberS = val["novemberS"];
    insect.decemberS = val["decemberS"];
    insects.add(insect);
  });
  return insects;
}

List<Villager> mapVillagersList(List<Map<String, dynamic>> qVillagers) {
  List<Villager> villagers = new List<Villager>();
  qVillagers.forEach((val) {
    Villager villager = new Villager();
    villager.number = val["number"];
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

List<Flower> mapFlowersList(String jsonFlowers) {
  List<Flower> flowers = new List<Flower>();
  List flowerRawList = json.decode(jsonFlowers);
  flowerRawList.forEach((val) {
    Flower flower = new Flower();
    flower.name = val["name"];
    flower.imageUrl = val["imageUrl"];
    flower.combinations = new List<Combination>();
    List flowerCombinations =  val["combinations"];
    flowerCombinations.forEach((comb) {
      Combination combination = new Combination();
      combination.combination = comb["combination"];
      combination.imageUrl1 = comb["imageUrl1"];
      combination.imageUrl2 = comb["imageUrl2"];
      combination.imageUrl3 = comb["imageUrl3"];
      flower.combinations.add(combination);
    });
    flowers.add(flower);
  });
  return flowers;
}
