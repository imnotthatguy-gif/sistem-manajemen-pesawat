
import 'dart:io';
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
  // CONNECT TO SQLITE DATABASE
  final db = sqlite3.open('mynotedb.db');

  // CREATE TABLE
  db.execute('''
    CREATE TABLE IF NOT EXISTS pesanan (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama_menu TEXT,
      harga INTEGER,
      quantity INTEGER,
      subtotal INTEGER
    )
  ''');

  // SIGNATURE MENU
  List<MenuItem> menu = [
    // MAIN DISHES
    FoodItem('American Double Cheese Burger', 55000, 'Main Dish'),
    FoodItem('Nashville Hot Chicken', 42000, 'Main Dish'),
    FoodItem('BBQ Beef Burger', 45000, 'Main Dish'),
    FoodItem('Mushroom Swiss Burger', 48000, 'Main Dish'),
    FoodItem('Philly Cheesesteak Sandwich', 52000, 'Main Dish'),
    FoodItem('Classic American Hot Dog', 30000, 'Main Dish'),

    // SIDE DISHES
    FoodItem('Loaded Cheese Fries', 28000, 'Side Dish'),
    FoodItem('Crispy Onion Rings', 22000, 'Side Dish'),
    FoodItem('Buffalo Chicken Wings', 35000, 'Side Dish'),

    // DRINKS AND DESSERTS
    DrinkItem('Oreo Chocolate Milkshake', 30000, 'Large'),
    DrinkItem('Strawberry Cheesecake Milkshake', 32000, 'Large'),
    DrinkItem('Classic Root Beer Float', 25000, 'Medium'),
    FoodItem('American Apple Pie', 20000, 'Dessert'),
    FoodItem('Chocolate Brownie Sundae', 28000, 'Dessert'),
  ];

  int total = 0;
  int totalItem = 0;

  print('======================================');
  print('       AMERICAN FAST FOOD');
  print('          SIGNATURE MENU');
  print('======================================');

  // DISPLAY MENU
  for (var item in menu) {
    print('${item.name} : Rp${item.price}');
  }

  print('======================================');

  // INPUT NUMBER OF MENU CHOICES
  stdout.write('Berapa jenis menu yang ingin dibeli? ');
  int jumlahMenu = int.parse(stdin.readLineSync()!);

  // CUSTOMER ORDER
  for (int i = 0; i < jumlahMenu; i++) {
    print('\nMenu pilihan ke-${i + 1}');

    stdout.write('Masukkan nama menu: ');
    String namaMenu = stdin.readLineSync()!;

    MenuItem selectedMenu = menu.firstWhere(
      (item) => item.name.toLowerCase() == namaMenu.toLowerCase(),
      orElse: () => MenuItem('', 0),
    );

    if (selectedMenu.name == '') {
      print('Menu tidak ditemukan! Silakan coba lagi.');
      i--;
      continue;
    }

    stdout.write('Masukkan jumlah pembelian: ');
    int quantity = int.parse(stdin.readLineSync()!);

    if (quantity <= 0) {
      print('Jumlah pembelian harus lebih dari 0!');
      i--;
      continue;
    }

    int subtotal = selectedMenu.price * quantity;

    total += subtotal;
    totalItem += quantity;

    // SAVE ORDER TO SQLITE DATABASE
    db.execute(
      '''
      INSERT INTO pesanan (nama_menu, harga, quantity, subtotal)
      VALUES (?, ?, ?, ?)
      ''',
      [
        selectedMenu.name,
        selectedMenu.price,
        quantity,
        subtotal
      ],
    );

    print('Subtotal: Rp$subtotal');
  }

  // DISCOUNT MECHANISM
  double diskonPersen = 0;

  if (totalItem > 4) {
    diskonPersen = 20;
  }

  int diskon = (total * diskonPersen / 100).round();

  // SHIPPING COST
  int ongkir = total > 50000 ? 0 : 5000;

  // FINAL PAYMENT
  int pembayaran = total - diskon + ongkir;

  // PAYMENT RECEIPT
 
  print('             PAYMENT RECEIPT');
 
  print('Total Item       : $totalItem');
  print('Total Belanja    : Rp$total');
  print('Diskon           : $diskonPersen%');
  print('Potongan Harga   : Rp$diskon');

  if (ongkir == 0) {
    print('Ongkir           : GRATIS');
  } else {
    print('Ongkir           : Rp$ongkir');
  }

  
  print('Total Pembayaran : Rp$pembayaran');
  

  print('Terima kasih sudah berbelanja!');

  db.dispose();
}
