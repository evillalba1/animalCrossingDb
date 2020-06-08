
class Fossil {
  int number;
  String name;
  String price;
  String donated;
  int quantity;

  Map<String, dynamic> toMap() {
  return {
    'number': number,
    'name': name,
    'price': price,
    'donated': donated,
    'quantity': quantity
    };
  }
}

class Fish {
  int number;
  String name;
  String location;
  String shadowSize;
  String value;
  String time;
  String month;
  String donated;
  int quantity;
  String imageUrl;

  Map<String, dynamic> toMap() {
  return {
    'number': number,
    'name': name,
    'location': location,
    'shadowSize': shadowSize,
    'value': value,
    'time': time,
    'month': month,
    'donated': donated,
    'quantity': quantity,
    'imageUrl': imageUrl,
    };
  }

}

class Insect {
  int number;
  String name;
  String location;
  String value;
  String time;
  String month;
  String donated;
  int quantity;
  String imageUrl;

  Map<String, dynamic> toMap() {
  return {
    'number': number,
    'name': name,
    'location': location,
    'value': value,
    'time': time,
    'month': month,
    'donated': donated,
    'quantity': quantity,
    'imageUrl': imageUrl,
    };
  }
}

class Villager {
  int number;
  String name;
  String personality;
  String species;
  String birthday;
  String catchphrase;
  String imageUrl;
  String resident;

  Map<String, dynamic> toMap() {
  return {
    'number': number,
    'name': name,
    'personality': personality,
    'species': species,
    'birthday': birthday,
    'catchphrase': catchphrase,
    'imageUrl': imageUrl,
    'resident': resident,
    };
  }
}

class VillagerTbl {
  String table = "villagers";
  String number = "number";
  String name = "name";
  String personality = "personality";
  String species = "species";
  String birthday = "birthday";
  String catchphrase = "catchphrase";
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
  String name = "name";
  String location = "location";
  String shadowSize = "shadowSize";
  String value = "value";
  String time = "time";
  String month = "month";
  String donated = "donated";
  String quantity = "quantity";
  String imageUrl = "imageUrl";
}

class InsectTbl {
  String table = "insect";
  String number = "number";
  String name = "name";
  String location = "location";
  String value = "value";
  String time = "time";
  String month = "month";
  String donated = "donated";
  String quantity = "quantity";
  String imageUrl = "imageUrl";
}