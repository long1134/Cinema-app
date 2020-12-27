import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/widgets/bottom_ticket_detail.dart';
import 'package:cinema_app/widgets/map_seat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmMapSeatScreen extends StatelessWidget {
  static const routeName = '/film-map-seat';
  @override
  Widget build(BuildContext context) {
    FilmItem film = Provider.of<Film>(context).getChoseFilm;
    print("map screen");
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ClipPath(
                      clipper: new MyClipper(),
                      child: Image.network(
                        "https://long-cinema-app.herokuapp.com/api/h/film/img/" +
                            film.img2,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 200,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
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
            //map widget
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              child: MapSeatWidget(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: GridView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, i) => Container(
                    child: Container(
                      height: 20,
                      width: 80,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: i == 0
                                  ? Colors.white
                                  : i == 1
                                      ? Color.fromRGBO(113, 113, 113, 1)
                                      : Color.fromRGBO(248, 168, 40, 1),
                            ),
                          ),
                          i == 0
                              ? Text(
                                  "Ghế trống",
                                  style: TextStyle(color: Colors.white),
                                )
                              : i == 1
                                  ? Text(
                                      "Ghế đã đặt",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      "Ghế bạn chọn",
                                      style: TextStyle(color: Colors.white),
                                    ),
                        ],
                      ),
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 30, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width / 2, 0, 0, 30);
    path.lineTo(0.0, 30.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
