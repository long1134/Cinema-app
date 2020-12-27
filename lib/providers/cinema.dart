import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CinemaItem {
  final String address;
  final String name;
  final String id;

  CinemaItem({
    @required this.id,
    @required this.address,
    @required this.name,
  });
}

class Cinema with ChangeNotifier {
  List<CinemaItem> _items = [];
  List<CinemaItem> get items {
    return _items;
  }

  String idCinemaChose;

  CinemaItem get getChoseCinema {
    CinemaItem cinema =
        _items.firstWhere((e) => e.id == idCinemaChose, orElse: () => null);
    return cinema;
  }

  void changeIndexCinema(String id) {
    idCinemaChose = id;
    notifyListeners();
  }

  CinemaItem getById(String id) {
    return _items.firstWhere((e) => e.id == id);
  }

  Future<void> getCinema() async {
    try {
      const url = "https://long-cinema-app.herokuapp.com/api/quest/cinema/";
      final client = new http.Client();
      if (_items.length != 0) {
        return;
      }
      final response = await client.get(
        url,
      );
      List<CinemaItem> temp = [];
      final data = json.decode(response.body) as List<dynamic>;
      data.forEach(
        (film) {
          temp.add(
            CinemaItem(
              id: film['_id'],
              address: film['address'],
              name: film['name'],
            ),
          );
        },
      );
      _items = temp;
      notifyListeners();
      return;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
