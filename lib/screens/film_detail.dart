import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/screens/film_booking.dart';
import 'package:cinema_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmDetailScreen extends StatelessWidget {
  static const routeName = '/film-detail';
  @override
  Widget build(BuildContext context) {
    final filmtId = ModalRoute.of(context).settings.arguments as String;
    final loadedFilm = Provider.of<Film>(context).findById(filmtId);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(24, 24, 40, 1)),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: Color.fromRGBO(24, 24, 40, 1),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: filmtId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    child: Container(
                      height: 100,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://long-cinema-app.herokuapp.com/api/h/film/img/" +
                                  loadedFilm.img2,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black26,
                              Color.fromRGBO(24, 24, 40, 1)
                            ])),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          loadedFilm.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: !(loadedFilm.rate > 0)
                                      ? Color.fromRGBO(99, 114, 134, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: !(loadedFilm.rate > 2)
                                      ? Color.fromRGBO(99, 114, 134, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: !(loadedFilm.rate > 4)
                                      ? Color.fromRGBO(99, 114, 134, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: !(loadedFilm.rate > 6)
                                      ? Color.fromRGBO(99, 114, 134, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                                ),
                                Icon(
                                  Icons.star,
                                  color: !(loadedFilm.rate > 8)
                                      ? Color.fromRGBO(99, 114, 134, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    loadedFilm.rate.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  loadedFilm.type,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  loadedFilm.time + " p",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  loadedFilm.country,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Khởi chiếu : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(87, 131, 165, 1),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              loadedFilm.dayShow,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(99, 114, 134, 1),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Nội dung : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${loadedFilm.content}',
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(99, 114, 134, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 50,
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(248, 168, 40, 1),
          label: Text("Đặt vé"),
          onPressed: () {
            Navigator.of(context).pushNamed(FilmBookingScreen.routeName,
                arguments: loadedFilm.id);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: AppDrawer(),
    );
  }
}
