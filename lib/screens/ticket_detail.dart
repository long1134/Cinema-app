import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/combo.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/providers/ticket_cinema.dart';
import 'package:cinema_app/providers/ticket_user.dart';
import 'package:cinema_app/screens/ticket_book_success.dart';
import 'package:cinema_app/screens/ticket_user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketDetailScreen extends StatefulWidget {
  static const routeName = '/ticket-detail';

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  @override
  Widget build(BuildContext context) {
    FilmItem film = Provider.of<Film>(context).getChoseFilm;
    CinemaItem cinema = Provider.of<Cinema>(context).getChoseCinema;
    ShowtimeItem showtime = Provider.of<Showtime>(context).getChoseShowtimeItem;
    String time = Provider.of<Showtime>(context).getTime;
    TicketCinemas ticket = Provider.of<TicketCinemas>(context);
    Combo combo = Provider.of<Combo>(context);
    bool isLoading = false;
    print(combo.items);

    showListTickets() {
      String name = "";
      ticket.listTicket.forEach((e) {
        name += e + " ";
        return e;
      });
      return Text(
        name,
        style: TextStyle(color: Colors.white),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 40, 1),
        title: Text(film.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(24, 24, 40, 1),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.network(
                                "https://long-cinema-app.herokuapp.com/api/h/film/img/" +
                                    film.img1,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 100,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            tag: film.id,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                film.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.location_on,
                                        color: Colors.white60),
                                  ),
                                  Text(
                                    cinema.name,
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.alarm,
                                        color: Colors.white60),
                                  ),
                                  Text(
                                    time.split("/").reversed.join("/") +
                                        " - " +
                                        showtime.timeShow,
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Color.fromRGBO(92, 198, 221, 0.3),
                        height: 0.05,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Thông tin giao dịch : ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Thông tin ghế : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          showListTickets()
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Thông tin combo : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: combo.items.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        combo.items[index].name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        combo.items[index].count.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Tổng thanh toán : ",
                                  style: TextStyle(color: Colors.white)),
                              Text(
                                  (ticket.countRevenue + combo.countRevenue)
                                          .toString() +
                                      " Đ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 50,
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(248, 168, 40, 1),
          label: !isLoading ? Text("Thanh Toán") : CircularProgressIndicator(),
          onPressed: isLoading
              ? null
              : () async {
                  isLoading = true;
                  await ticket.payTicket(showtime, film.name, combo);
                  isLoading = false;
                  Navigator.of(context)
                      .pushNamed(TicketBookSuccessScreen.routeName);
                },
        ),
      ),
    );
  }
}
