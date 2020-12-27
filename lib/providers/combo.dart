import 'package:flutter/cupertino.dart';

class ComboItem with ChangeNotifier {
  final int price;
  final String name;
  final String detail;
  int count = 0;
  int total = 0;

  ComboItem(this.price, this.name, this.detail);
}

class Combo with ChangeNotifier {
  List<ComboItem> _items = [
    ComboItem(85000, 'Combo 1', "1 Bắp + 1 Nước"),
    ComboItem(81000, 'Combo 2', "1 Bắp + 2 Nước"),
    ComboItem(162000, 'Family 2 Voucher', "2 Bắp + 4 Nước + 1 Snack"),
  ];

  int countCombo = 0;
  int countRevenue = 0;

  List<ComboItem> get items {
    return _items;
  }

  void initTicket() {
    _items = [
      ComboItem(85000, 'Combo 1', "1 Bắp + 1 Nước"),
      ComboItem(81000, 'Combo 2', "1 Bắp + 2 Nước"),
      ComboItem(162000, 'Family 2 Voucher', "2 Bắp + 4 Nước + 1 Snack"),
    ];
    countCombo = 0;
    countRevenue = 0;
    notifyListeners();
  }

  void addCombo(String nameCombo) {
    int index = _items.indexWhere((combo) {
      if (combo.name == nameCombo) {
        countCombo++;
        countRevenue += combo.price;
      }
      return combo.name == nameCombo;
    });
    _items[index].count = _items[index].count + 1;
    notifyListeners();
  }

  void removeCombo(String nameCombo) {
    int index = _items.indexWhere((combo) {
      if (combo.name == nameCombo) {
        if (countCombo > 0) {
          countCombo--;
          countRevenue -= combo.price;
        }
      }
      return combo.name == nameCombo;
    });
    if (_items[index].count > 0) _items[index].count--;
    notifyListeners();
  }
}
