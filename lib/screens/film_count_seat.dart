import 'package:cinema_app/providers/auth.dart';
import 'package:cinema_app/providers/cinema.dart';
import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/providers/showtime.dart';
import 'package:cinema_app/screens/login.dart';
import 'package:cinema_app/widgets/bottom_ticket_detail.dart';
import 'package:cinema_app/widgets/choose_ticket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmCountSeatScreen extends StatelessWidget {
  static const routeName = '/film-count-seat';
  @override
  Widget build(BuildContext context) {
    FilmItem film = Provider.of<Film>(context).getChoseFilm;
    CinemaItem cinema = Provider.of<Cinema>(context).getChoseCinema;
    ShowtimeItem showtime = Provider.of<Showtime>(context).getChoseShowtimeItem;
    String time = Provider.of<Showtime>(context).getTime;
    Auth auth = Provider.of<Auth>(context);
    return FutureBuilder(
      initialData: Center(
        child: CircularProgressIndicator(),
      ),
      future: auth.tryLogin(),
      builder: (ctx, snapShot) {
        print(auth.isAuth);
        return auth.isAuth
            ? Scaffold(
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
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      tag: film.id,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          film.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(Icons.location_on,
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              cinema.name,
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(Icons.alarm,
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              time
                                                      .split("/")
                                                      .reversed
                                                      .join("/") +
                                                  " - " +
                                                  showtime.timeShow,
                                              style: TextStyle(
                                                  color: Colors.white60),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                ChooseTicketWidget(film, cinema, showtime),
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
              )
            : LoginScreen();
      },
    );
  }
}
