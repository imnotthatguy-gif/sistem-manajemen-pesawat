import 'package:sqlite3/sqlite3.dart';
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price);
}

class FoodItem extends MenuItem {
  String foodType;

  FoodItem(String name, int price, this.foodType)
      : super(name, price);
}

class DrinkItem extends MenuItem {
  String drinkSize;

  DrinkItem(String name, int price, this.drinkSize)
      : super(name, price);
}

void main() {
  List<MenuItem> menu = [
    FoodItem('Burger', 25000, 'Fast Food'),
    FoodItem('Kentang Goreng', 15000, 'Snack'),
    DrinkItem('Es Teh', 10000, 'Medium'),
    DrinkItem('Kopi', 20000, 'Large'),
  ];

  int total = 0;

  for (var item in menu) {
    print('${item.name} : Rp${item.price}');
    total += item.price;
  }

  int ongkir = total > 50000 ? 0 : 5000;
  int pembayaran = total + ongkir;

  print('----------------------');
  print('Total Belanja : Rp$total');

  if (ongkir == 0) {
    print('Ongkir : GRATIS');
  } else {
    print('Ongkir : Rp$ongkir');
  }

  print('Total Pembayaran : Rp$pembayaran');
}









