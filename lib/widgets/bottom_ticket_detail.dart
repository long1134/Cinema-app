import 'package:cinema_app/providers/combo.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:cinema_app/screens/film_booking.dart';
import 'package:cinema_app/screens/film_combo.dart';
import 'package:cinema_app/screens/film_count_seat.dart';
import 'package:cinema_app/screens/film_map_seat.dart';
import 'package:cinema_app/screens/login.dart';
import 'package:cinema_app/screens/ticket_detail.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomTicketDetailWidget extends StatefulWidget {
  @override
  _BottomTicketDetailWidgetState createState() =>
      _BottomTicketDetailWidgetState();
}

class _BottomTicketDetailWidgetState extends State<BottomTicketDetailWidget> {
  @override
  Widget build(BuildContext context) {
    String routeName = ModalRoute.of(context).settings.name;
    final ticketCinemas = Provider.of<TicketCinemas>(context);
    final countCombo = Provider.of<Combo>(context).countCombo;
    final countRevenueCombo = Provider.of<Combo>(context).countRevenue;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(40, 40, 56, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tổng cộng : ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          ticketCinemas.countTickets.toString() + " Vé ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          countCombo.toString() + " Combo",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Text(
                      (ticketCinemas.countRevenue + countRevenueCombo)
                              .toString() +
                          " đ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  disabledColor: Color.fromRGBO(248, 168, 40, 0.5),
                  color: Color.fromRGBO(248, 168, 40, 1),
                  onPressed: (routeName == FilmCountSeatScreen.routeName &&
                              ticketCinemas.countTickets == 0) ||
                          (routeName == FilmMapSeatScreen.routeName &&
                              ticketCinemas.listTicket.length !=
                                  ticketCinemas.countTickets)
                      ? null
                      : () {
                          if (routeName == FilmCountSeatScreen.routeName)
                            Navigator.of(context)
                                .pushNamed(FilmComboScreen.routeName);
                          if (routeName == FilmComboScreen.routeName)
                            Navigator.of(context)
                                .pushNamed(FilmMapSeatScreen.routeName);
                          if (routeName == FilmMapSeatScreen.routeName)
                            Navigator.of(context)
                                .pushNamed(TicketDetailScreen.routeName);
                        },
                  child: Container(
                    child: Text(
                      "Tiếp tục",
                      style: TextStyle(color: Color.fromRGBO(24, 24, 40, 1)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
