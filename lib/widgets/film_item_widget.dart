import 'package:cinema_app/providers/film.dart';
import 'package:cinema_app/screens/film_detail.dart';
import 'package:flutter/material.dart';

class FilmItemWidget extends StatefulWidget {
  final FilmItem film;
  FilmItemWidget(this.film);
  @override
  _FilmItemWidgetState createState() => _FilmItemWidgetState(film);
}

class _FilmItemWidgetState extends State<FilmItemWidget>
    with AutomaticKeepAliveClientMixin<FilmItemWidget> {
  final FilmItem film;
  _FilmItemWidgetState(this.film);
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
              color: Color.fromRGBO(40, 40, 56, 1),
              border: Border.all(width: 0)),
          child: Row(
            children: <Widget>[
              Container(
                height: 300,
                width: 80,
                child: Hero(
                  tag: film.id,
                  child: Image.network(
                    "https://long-cinema-app.herokuapp.com/api/h/film/img/" +
                        film.img1,
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        film.name,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
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
                            film.dayShow,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(99, 114, 134, 1),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Color.fromRGBO(128, 150, 172, 1),
                                size: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                  film.time + " m",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  FilmDetailScreen.routeName,
                                  arguments: film.id);
                            },
                            child: Text("Mua vé"),
                            color: Color.fromRGBO(248, 168, 40, 1),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
