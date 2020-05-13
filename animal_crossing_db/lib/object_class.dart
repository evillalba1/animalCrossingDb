
class Fossil {
  String number;
  String name;
  String price;
  bool donated;
  int quantity;
}

class Fish {
  String number;
  String name;
  String location;
  String shadowSize;
  String value;
  String time;
  String month;
  bool donated;
  int quantity;
}

class Insect {
  String number;
  String name;
  String location;
  String value;
  String time;
  String month;
  bool donated;
  int quantity;
}

class Villager {
  String number;
  String name;
  String personality;
  String species;
  String birthday;
  String catchphrase;
  String imageUrl;
}

class VillagerTbl {
  String table = "villagers";
  String number = "number";
  String name = "name";
  String personality = "personality";
  String species = "species";
  String birthday = "birthday";
  String cathphrase = "cathphrase";
  String imageUrl = "imageUrl";
  String resident = "resident";
}

class FossilTbl {
  String table = "fossils";
  String number = "number";
  String name = "name";
  String price = "price";
  String donated = "donated";
  String quantity = "quantity";

  FossilTbl();
}

class FishTbl {
  String table = "fish";
  String number = "number";
  String name = "insect";
  String location = "location";
  String shadowSize = "shadowSize";
  String value = "value";
  String time = "time";
  String month = "month";
  String donated = "donated";
  String quantity = "quantity";
}

class InsectTbl {
  String table = "insect";
  String number = "number";
  String name = "insect";
  String location = "location";
  String value = "value";
  String time = "time";
  String month = "month";
  String donated = "donated";
  String quantity = "quantity";
}