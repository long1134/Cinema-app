import 'dart:convert';

import 'package:cinema_app/providers/combo.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TicketCinemaItem with ChangeNotifier {
  final int price;
  final String name;
  int count = 0;
  int total = 0;

  TicketCinemaItem(this.price, this.name);
}

class TicketCinemas with ChangeNotifier {
  List<TicketCinemaItem> _items = [
    TicketCinemaItem(85000, 'Người lớn'),
    TicketCinemaItem(65000, 'Members'),
    TicketCinemaItem(55000, 'Trẻ em'),
    TicketCinemaItem(55000, 'Sinh viên')
  ];

  int countTickets = 0;
  int countRevenue = 0;
  String idTicket = "";
  List<String> listTicket = [];

  List<TicketCinemaItem> get items {
    return _items;
  }

  void handleListTicket(int x, int y, bool isValid) {
    if (!isValid) {
      return;
    }
    const alpha = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "Q",
      "Z",
      "Y",
      "Z"
    ];
    print("list ticket");
    print(listTicket);
    if (listTicket.length == countTickets) {
      if (listTicket.indexOf(alpha[x] + y.toString()) != -1) {
        listTicket.removeAt(0);
        notifyListeners();
        return;
      }
      listTicket.removeAt(0);
      listTicket.add(alpha[x] + y.toString());
      notifyListeners();
      return;
    } else if (listTicket.length < countTickets) {
      listTicket.add(alpha[x] + y.toString());
    } else {
      listTicket.remove((e) => e == alpha[x] + y.toString());
    }
    notifyListeners();
  }

  void initTicket() {
    _items = [
      TicketCinemaItem(85000, 'Người lớn'),
      TicketCinemaItem(65000, 'Members'),
      TicketCinemaItem(55000, 'Trẻ em'),
      TicketCinemaItem(55000, 'Sinh viên')
    ];
    countTickets = 0;
    countRevenue = 0;
    notifyListeners();
  }

  void payTicket(ShowtimeItem showtime, String filmName, Combo combo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final extractedData = await json.decode(preferences.getString('userData'))
        as Map<String, Object>;
    var _token = extractedData['token'];
    var detailSeats = listTicket;
    var showtimes = showtime.map.map((seats) {
      return seats.map((seat) => seat == 2 ? 1 : seat);
    });
    var newShowtimes = [];
    for (var i in showtimes) {
      var j = [];
      for (var temp in i) {
        j.add(temp);
      }
      newShowtimes.add(j);
    }
    var newCombo = [];
    var newTickets = [];
    for (var i in combo.items) {
      if (i.count != 0) {
        newCombo.add({
          "name": i.name,
          "detail": i.detail,
          "price": i.price,
          "count": i.count,
          "total": i.count * i.price
        });
      }
    }
    for (var i in _items) {
      if (i.count != 0) {
        newTickets.add({
          "name": i.name,
          "price": i.price,
          "count": i.count,
          "total": i.count * i.price
        });
      }
    }
    var data = {
      "showtimes": {
        "combo": newCombo,
        "detailTickets": newTickets,
        "revenue": combo.countRevenue + countRevenue,
        "revenueTickets": countRevenue,
        "revenueCombo": combo.countRevenue
      },
      // "detailSeats": detailSeats,
      "filmName": filmName,
      "token": _token,
    };
    const url =
        "https://long-cinema-app.herokuapp.com/api/quest/showtimes/pay/";
    print("endcode");
    print(json.encode({
      "showtimes": {
        "map": newShowtimes,
        "combo": newCombo,
        "detailTickets": newTickets,
        "revenue": combo.countRevenue + countRevenue,
        "revenueTickets": countRevenue,
        "revenueCombo": combo.countRevenue
      },
      "detailSeats": detailSeats,
      "filmName": filmName,
      "token": _token,
    }));
    final response = await http.put(
      url + showtime.id,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "showtimes": {
          "map": newShowtimes,
          "combo": newCombo,
          "detailTickets": newTickets,
          "revenue": combo.countRevenue + countRevenue,
          "revenueTickets": countRevenue,
          "revenueCombo": combo.countRevenue
        },
        "detailSeats": detailSeats,
        "filmName": filmName,
        "token": _token,
      }),
    );
    final responseData = json.decode(response.body);
    idTicket = responseData["_id"];
    print(idTicket);
    notifyListeners();
  }

  void addTickets(String nameTicket) {
    int index = _items.indexWhere((ticket) {
      if (ticket.name == nameTicket) {
        countTickets++;
        countRevenue += ticket.price;
      }
      return ticket.name == nameTicket;
    });
    _items[index].count = _items[index].count + 1;
    notifyListeners();
  }

  void removeTickets(String nameTicket) {
    int index = _items.indexWhere((ticket) {
      if (ticket.name == nameTicket) {
        if (countTickets > 0) {
          countTickets--;
          countRevenue -= ticket.price;
        }
      }
      return ticket.name == nameTicket;
    });
    if (_items[index].count > 0) _items[index].count--;
    notifyListeners();
  }
}
