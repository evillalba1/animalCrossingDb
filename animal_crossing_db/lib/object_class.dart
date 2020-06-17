
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
  String january;
  String february;
  String march;
  String april;
  String may;
  String june;
  String july;
  String august;
  String september;
  String october;
  String november;
  String december;
  String januaryS;
  String februaryS;
  String marchS;
  String aprilS;
  String mayS;
  String juneS;
  String julyS;
  String augustS;
  String septemberS;
  String octoberS;
  String novemberS;
  String decemberS;
  

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
    'january': january,
    'february': february,
    'march': march,
    'april': april,
    'may': may,
    'june': june,
    'july': july,
    'august': august,
    'september': september,
    'october': october,
    'november': november,
    'december': december,
    'januaryS': januaryS,
    'februaryS': februaryS,
    'marchS': marchS,
    'aprilS': aprilS,
    'mayS': mayS,
    'juneS': juneS,
    'julyS': julyS,
    'augustS': augustS,
    'septemberS': septemberS,
    'octoberS': octoberS,
    'novemberS': novemberS,
    'decemberS': decemberS,
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
  String january;
  String february;
  String march;
  String april;
  String may;
  String june;
  String july;
  String august;
  String september;
  String october;
  String november;
  String december;
  String januaryS;
  String februaryS;
  String marchS;
  String aprilS;
  String mayS;
  String juneS;
  String julyS;
  String augustS;
  String septemberS;
  String octoberS;
  String novemberS;
  String decemberS;

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
    'january': january,
    'february': february,
    'march': march,
    'april': april,
    'may': may,
    'june': june,
    'july': july,
    'august': august,
    'september': september,
    'october': october,
    'november': november,
    'december': december,
    'januaryS': januaryS,
    'februaryS': februaryS,
    'marchS': marchS,
    'aprilS': aprilS,
    'mayS': mayS,
    'juneS': juneS,
    'julyS': julyS,
    'augustS': augustS,
    'septemberS': septemberS,
    'octoberS': octoberS,
    'novemberS': novemberS,
    'decemberS': decemberS,
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

class Flower {
  String name;
  String imageUrl;
  List<Combination> combinations;
}

class Combination {
  String combination;
  String imageUrl1;
  String imageUrl2;
  String imageUrl3;
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
  String january = "january";
  String february = "february";
  String march = "march";
  String april = "april";
  String may = "may";
  String june = "june";
  String july = "july";
  String august = "august";
  String september = "september";
  String october = "october";
  String november = "november";
  String december = "december";
  String januaryS = "januaryS";
  String februaryS = "februaryS";
  String marchS = "marchS";
  String aprilS = "aprilS";
  String mayS = "mayS";
  String juneS = "juneS";
  String julyS = "julyS";
  String augustS = "augustS";
  String septemberS = "septemberS";
  String octoberS = "octoberS";
  String novemberS = "novemberS";
  String decemberS = "decemberS";
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
  String january = "january";
  String february = "february";
  String march = "march";
  String april = "april";
  String may = "may";
  String june = "june";
  String july = "july";
  String august = "august";
  String september = "september";
  String october = "october";
  String november = "november";
  String december = "december";
  String januaryS = "januaryS";
  String februaryS = "februaryS";
  String marchS = "marchS";
  String aprilS = "aprilS";
  String mayS = "mayS";
  String juneS = "juneS";
  String julyS = "julyS";
  String augustS = "augustS";
  String septemberS = "septemberS";
  String octoberS = "octoberS";
  String novemberS = "novemberS";
  String decemberS = "decemberS";
}