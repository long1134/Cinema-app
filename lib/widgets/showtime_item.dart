import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:cinema_app/screens/film_combo.dart';
import 'package:cinema_app/screens/film_count_seat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowtimeItemWidget extends StatefulWidget {
  final CinemaItem cinema;
  final String idFilm;
  ShowtimeItemWidget(this.cinema, this.idFilm);

  @override
  _ShowtimeItemWidgetState createState() => _ShowtimeItemWidgetState();
}

class _ShowtimeItemWidgetState extends State<ShowtimeItemWidget> {
  List<ShowtimeItem> listShowtime;
  @override
  void didChangeDependencies() {
    listShowtime = Provider.of<Showtime>(context)
        .getShowtime(widget.cinema.id, widget.idFilm, "30/10/2019");
    listShowtime.sort((a, b) => a.timeShow.compareTo(b.timeShow));
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: Color.fromRGBO(92, 198, 221, 0.3),
          height: 0.05,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.cinema.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: listShowtime.length > 5 ? 70 * listShowtime.length / 5 : 70,
          width: MediaQuery.of(context).size.width,
          child: listShowtime.length != 0
              ? GridView.builder(
                  itemCount: listShowtime.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: listShowtime[i],
                    child: Container(
                      width: 20,
                      height: 20,
                      padding: EdgeInsets.only(top: 10, left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(92, 198, 221, 1),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<TicketCinemas>(context).initTicket();
                          Provider.of<Cinema>(context)
                              .changeIndexCinema(widget.cinema.id);
                          Provider.of<Film>(context)
                              .changeIndexFilm(widget.idFilm);
                          Provider.of<Showtime>(context)
                              .changeIdShowtimeChose(listShowtime[i].id);
                          Navigator.of(context)
                              .pushNamed(FilmCountSeatScreen.routeName);
                        },
                        child: Text(
                          listShowtime[i].timeShow,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 5 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                )
              : Container(
                  child: Text(
                    "Không có lịch chiếu",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ],
    );
  }
}
