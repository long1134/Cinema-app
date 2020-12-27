import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTicketWidget extends StatefulWidget {
  final ShowtimeItem showtime;
  final CinemaItem cinema;
  final FilmItem film;

  ChooseTicketWidget(this.film, this.cinema, this.showtime);

  @override
  _ChooseTicketWidgetState createState() => _ChooseTicketWidgetState();
}

class _ChooseTicketWidgetState extends State<ChooseTicketWidget> {
  @override
  Widget build(BuildContext context) {
    List<TicketCinemaItem> tickets = Provider.of<TicketCinemas>(context).items;
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      child: tickets.length != 0
          ? ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (ctx, index) => Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          tickets[index].name,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Provider.of<TicketCinemas>(context)
                                      .removeTickets(tickets[index].name);
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Container(
                                  height: 25,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white60),
                                  ),
                                  child: Text(
                                    tickets[index].count.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Provider.of<TicketCinemas>(context)
                                      .addTickets(tickets[index].name);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
