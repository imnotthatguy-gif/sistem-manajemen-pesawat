import 'package:sqlite3/sqlite3.dart';

class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);
}

class FoodItem extends MenuItem {
  String foodType;

  FoodItem(String name, double price, this.foodType) : super(name, price);
}

class DrinkItem extends MenuItem {
  String drinkSize;

  DrinkItem(String name, double price, this.drinkSize) : super(name, price);
}

