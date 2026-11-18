import 'package:sqlite3/sqlite3.dart';

class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price);

  void displayInfo() {
    print('${name} : ${price}');
  }
}

class FoodItem extends MenuItem {
  String foodType;

  FoodItem(String name, int price, this.foodType) : super(name, price);

  @override displayInfo() {
    print('${foodType}, ${name} : ${price}');
  }
}

class DrinkItem extends MenuItem {
  String drinkSize;

  DrinkItem(String name, int price, this.drinkSize) : super(name, price);

  @override displayInfo() {
    print('${drinkSize}, ${name} : ${price}');
  }
}




