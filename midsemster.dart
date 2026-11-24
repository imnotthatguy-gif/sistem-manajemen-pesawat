import 'dart:math';
class DiscountStrategy {
  String _name;

  DiscountStrategy(this._name);
 
  String get name => _name;

  set name(String value) {
    _name = value;
  }

  double calculateDiscount(double orderAmount) {
    return 0.0;
  }
}

class PercentageDiscount extends DiscountStrategy {
  double _percentage;
  double _maxDiscount;

  PercentageDiscount(this._percentage, this._maxDiscount)
      : super('diskon $_percentage%');

  double get percentage => _percentage;
  set percentage(double value) {
    _percentage = value;
  }

  double get maxDiscount => _maxDiscount;
  set maxDiscount(double value) {
    _maxDiscount = value;
  }

  @override
  double calculateDiscount(double orderAmount) {
    double rawDiscount = orderAmount * (this.percentage / 100.0);
    return min(rawDiscount, this.maxDiscount);
  }
}

class FixedAmountDiscount extends DiscountStrategy {
  double _fixedAmount;
  double _minOrderAmount;

  FixedAmountDiscount(this._fixedAmount, this._minOrderAmount)
      : super('voucher potongan Rp $_fixedAmount');

  double get fixedAmount => _fixedAmount;
  set fixedAmount(double value) {
    _fixedAmount = value;
  }

  double get minOrderAmount => _minOrderAmount;
  set minOrderAmount(double value) {
    _minOrderAmount = value;
  }

  @override
  double calculateDiscount(double orderAmount) {
    if (orderAmount < _minOrderAmount) {
      return 0;
    }
    return min(this.fixedAmount, orderAmount);
  }
}

class BuyOneGetOneFreeDiscount extends DiscountStrategy {
  BuyOneGetOneFreeDiscount() : super('buy one get one free');

  @override
  double calculateDiscount(double orderAmount) {
    return orderAmount;
  }
}


class Checkout {
  double _orderAmount;
  DiscountStrategy? _discountStrategy;
  Checkout(this._orderAmount, this._discountStrategy);
  double getFinalTotal() {
    if (this._discountStrategy == null) {
      return  this._orderAmount;
    }
    double discountAmount = 
    _discountStrategy!.calculateDiscount (_orderAmount);
      return _orderAmount - discountAmount;
  }
  void printReciept() {
    String discountName = "";
    if (this._discountStrategy !=null) {
     discountName = this._discountStrategy!.name;
    }
    double discountVal = 0;
    if(this._discountStrategy !=null) {
      discountVal = 
    this._discountStrategy!.calculateDiscount(_orderAmount);
    }
  double finalAmount = getFinalTotal();
  print('total belanja : Rp $_orderAmount');
  print('metode diskon: $discountName');
  print('potongan harga : -Rp ${discountVal}');
  print('total akhir : ${finalAmount}');
}
}

void main() {
  PercentageDiscount diskonPersen = PercentageDiscount(10, 20000);
  FixedAmountDiscount diskonVoucher = FixedAmountDiscount(25000, 100000);
  BuyOneGetOneFreeDiscount diskonBogo = BuyOneGetOneFreeDiscount();

  Checkout checkout1 = Checkout(500000, diskonPersen);
  Checkout checkout2 = Checkout(150000, diskonVoucher);
  Checkout checkout3 = Checkout(100000, diskonBogo);

  checkout1.printReciept();
  checkout2.printReciept();
  checkout3.printReciept();
}