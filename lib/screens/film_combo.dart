import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/screens/film_map_seat.dart';
import 'package:cinema_app/widgets/bottom_ticket_detail.dart';
import 'package:cinema_app/widgets/combo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmComboScreen extends StatelessWidget {
  static const routeName = '/film-combo';
  @override
  Widget build(BuildContext context) {
    FilmItem film = Provider.of<Film>(context).getChoseFilm;
    CinemaItem cinema = Provider.of<Cinema>(context).getChoseCinema;
    ShowtimeItem showtime = Provider.of<Showtime>(context).getChoseShowtimeItem;
    String time = Provider.of<Showtime>(context).getTime;
    print("Route combo");
    print(ModalRoute.of(context).settings.name);
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
                height: MediaQuery.of(context).size.height * 0.8,
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
                        "Thông tin vé : ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      ComboWidget(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: BottomTicketDetailWidget(),
            )
          ],
        ),
      ),
    );
  }
}
