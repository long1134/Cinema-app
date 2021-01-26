import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TicketUserItem {
  final List foodDetail;
  final List seatsDetail;
  final String id;
  final String seatName;
  final int price;
  final String dayShow;
  final String timeShow;
  final String cinemaName;
  final String filmName;
  final String img;

  TicketUserItem({
    @required this.id,
    @required this.foodDetail,
    @required this.seatsDetail,
    @required this.seatName,
    @required this.price,
    @required this.dayShow,
    @required this.timeShow,
    @required this.cinemaName,
    @required this.filmName,
    @required this.img,
  });
}

class TicketUser with ChangeNotifier {
  List<TicketUserItem> _items = [];
  List<TicketUserItem> get items {
    return _items;
  }

  Future<void> initUserTicket() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final extractedData = await json.decode(preferences.getString('userData'))
        as Map<String, Object>;
    const url = "http://long-cinema-app.herokuapp.com/api/h/member/ticket";
    var _token = extractedData['token'];
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {'token': _token},
      ),
    );
    var data = json.decode(response.body);
    _items = [];
    for (var i in data) {
      _items.add(new TicketUserItem(
        cinemaName: i["cinemaName"],
        foodDetail: i["foodsDetail"],
        seatsDetail: i["seatsDetail"],
        price: i["price"],
        dayShow: i["dayShow"],
        timeShow: i["timeShow"],
        filmName: i["filmName"],
        seatName: i["seatName"],
        id: i["_id"],
        img: i["img"],
      ));
    }
    print('_items' + _items.toString());
    notifyListeners();
  }

  String idTicketChose;

  void changeIdTicketChose(String id) {
    idTicketChose = id;
    notifyListeners();
  }

  TicketUserItem get getChoseTicket {
    print(idTicketChose);
    TicketUserItem ticket =
        _items.firstWhere((e) => e.id == idTicketChose, orElse: () => null);
    return ticket;
  }
}
