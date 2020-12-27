import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ShowtimeItem with ChangeNotifier {
  final String idTheater;
  final String id;
  final String idCinema;
  final String idFilm;
  final String dayShow;
  final String timeShow;
  final map;
  final bool status;
  final tickets;
  final combo;
  final detailTickets;
  final int revenueCombo;
  final int revenueTickets;
  final int revenue;

  ShowtimeItem({
    @required this.id,
    @required this.idTheater,
    @required this.idCinema,
    @required this.idFilm,
    @required this.dayShow,
    @required this.timeShow,
    @required this.map,
    @required this.status,
    @required this.tickets,
    @required this.combo,
    @required this.detailTickets,
    @required this.revenueCombo,
    @required this.revenueTickets,
    @required this.revenue,
  });
}

class Showtime with ChangeNotifier {
  List<ShowtimeItem> _items = [];
  List<ShowtimeItem> get items {
    return _items;
  }

  ShowtimeItem tempShowtime;
  List<String> tempList = [];

  String time = "2019/10/30";
  String idChose;

  ShowtimeItem getById(String id) {
    return _items.firstWhere((e) => e.id == id);
  }

  String get getTime {
    return time;
  }

  void changeTime(String time) {
    this.time = time;
    notifyListeners();
  }

  ShowtimeItem get getChoseShowtimeItem {
    ShowtimeItem showtime = tempShowtime;
    return showtime;
  }

  void changeIdShowtimeChose(String index) {
    idChose = index;
    ShowtimeItem temp;
    temp = _items.firstWhere((e) => e.id == idChose, orElse: () => null);
    tempShowtime = ShowtimeItem(
      id: temp.id,
      idCinema: temp.idCinema,
      dayShow: temp.dayShow,
      idFilm: temp.idFilm,
      idTheater: temp.idTheater,
      timeShow: temp.timeShow,
      tickets: temp.tickets,
      revenue: temp.revenue,
      revenueCombo: temp.revenueCombo,
      detailTickets: temp.detailTickets,
      status: temp.status,
      revenueTickets: temp.revenueTickets,
      map: temp.map,
      combo: temp.combo,
    );
    notifyListeners();
  }

  void changeMapSeat(int x, int y, bool isMoreTicket) {
    //if ticket is book return
    if (tempShowtime.map[x][y] == 1) return;
    //if more  tickets than count delete the first
    if (isMoreTicket) {
      if (int.parse(tempList[0].substring(0, 1)) != x ||
          int.parse(tempList[0].substring(1, 2)) != y) {
        tempShowtime.map[int.parse(tempList[0].substring(0, 1))]
            [int.parse(tempList[0].substring(1, 2))] = 0;
        tempList.removeAt(0);
      }
    }
    //if ticket is empty book it
    if (tempShowtime.map[x][y] == 0) {
      tempList.add(x.toString() + y.toString());
      tempShowtime.map[x][y] = 2;
    }
    //if ticket is the last you chose remove it
    else if (tempShowtime.map[x][y] == 2) {
      tempShowtime.map[x][y] = 0;
      tempList.removeAt(tempList.indexOf(x.toString() + y.toString()));
    }
    notifyListeners();
  }

  Future<void> initShowtime(String idFilm, String day) async {
    final client = new http.Client();
    const url =
        "https://long-cinema-app.herokuapp.com/api/quest/showtimes/mobile";
    // http://10.0.2.2:8080/api/quest/showtimes/mobile
    try {
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {'idFilm': idFilm, 'dayShow': time},
        ),
      );
      final data = json.decode(response.body) as List<dynamic>;
      List<ShowtimeItem> temp = [];
      data.forEach(
        (film) {
          temp.add(
            ShowtimeItem(
              id: film['_id'],
              idCinema: film['idCinema'],
              dayShow: film['dayShow'],
              idFilm: film['idFilm'],
              idTheater: film['idTheater'],
              timeShow: film['timeShow'],
              tickets: film['tickets'],
              revenue: film['revenue'],
              revenueCombo: film['revenueCombo'],
              detailTickets: film['detailTickets'],
              status: film['status'],
              revenueTickets: film['revenueTickets'],
              map: film['map'],
              combo: film['combo'],
            ),
          );
        },
      );
      _items = temp;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  List<ShowtimeItem> getShowtime(
      String cinemaId, String filmId, String dayShow) {
    List<ShowtimeItem> temp = _items
        .where(
          (showtime) => (showtime.idCinema == cinemaId &&
              showtime.idFilm == filmId &&
              showtime.dayShow == time),
        )
        .toList();
    return temp;
  }
}
